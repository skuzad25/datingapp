//
//  Alert + Extension.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import Foundation
import UIKit
import CryptoSwift


var appNameAlert = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String

class Toast {
    static func show(message: String, controller: UIViewController) {
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])
        
        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -75)
        controller.view.addConstraints([c1, c2, c3])
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}


extension Optional where Wrapped == String {
    func leoSafe(defaultValue : String? = "") -> String {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf.isEmpty ? defaultValue! : strongSelf
    }
}


extension UITextField {
    
    func isValidEmailAddress() -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z_%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,6}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self.text.leoSafe() as NSString
            let results = regex.matches(in: self.text.leoSafe(), range: NSRange(location: 0, length: nsString.length))
            if results.count == 0{
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    
    func isEmptyy() -> Bool {
        return self.text!.trimmingCharacters(in: .whitespacesAndNewlines).count == 0
    }
    
    
    func isValidPassword(password: String) -> Bool {
       // let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        debugPrint(passwordRegex)
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

}


class Animations {
    static func requireUserAttention(on onView: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: onView.center.x - 10, y: onView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: onView.center.x + 10, y: onView.center.y))
        onView.layer.borderColor = #colorLiteral(red: 0.9411764741, green: 0.1038672596, blue: 0.0641536617, alpha: 1)
        onView.layer.add(animation, forKey: "position")
    }
}



extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


class Alert: UIAlertController {
    class func showSimpleAlert(_ message: String, completionHandler: (() -> Swift.Void)? = nil) {
        let keywindow = UIApplication.shared.keyWindow
        // let mainController = keywindow?.rootViewController
        let alert = UIAlertController(title: appNameAlert, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) in
            print("Heloo ")
            completionHandler?()
        }))
        UIApplication.topViewController()?.present(alert, animated: true, completion: {
        })
        
    }
    
    // make sure you have navigation  view controller
    
    class func showComplexAlert(title: String? = "",
                           message: String,
                           preferredStyle: UIAlertController.Style? = .alert,
                           cancelTilte: String,
                           otherButtons: String ...,
                           comletionHandler: ((Swift.Int) -> Swift.Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle!)
        
        for i in otherButtons {
            //  print( UIApplication.topViewController() ?? i  )
            
            alert.addAction(UIAlertAction(title: i, style: UIAlertAction.Style.default,
                                          handler: { (action: UIAlertAction!) in
                
                comletionHandler?(alert.actions.firstIndex(of: action)!)
                
            }
                                         ))
            
        }
        if (cancelTilte as String?) != nil {
            alert.addAction(UIAlertAction(title: cancelTilte, style: UIAlertAction.Style.destructive,
                                          handler: { (action: UIAlertAction!) in
                
                comletionHandler?(alert.actions.firstIndex(of: action)!)
                
            }
                                         ))
        }
        
        UIApplication.topViewController()?.present(alert, animated: true, completion: {
            
        })
        
    }
    
    class func showAlertWithOkCancel(message: String, actionOk: String, actionCancel: String, completionOk: @escaping(() -> ()), completionCancel: @escaping(() -> ())) {
        let alert = UIAlertController(title: appNameAlert, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: actionOk, style: .default) { (_) in
            completionOk()
        }
        let actionCancel = UIAlertAction(title: actionCancel, style: .default){ (_) in
            completionCancel()
        }
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    class func showAlertWithOkCancelLogout(message: String, actionOk: String, actionCancel: String, completionOk: @escaping(() -> ()), completionCancel: @escaping(() -> ())) {
        let alert = UIAlertController(title: "Sign out", message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: actionOk, style: .default) { (_) in
            completionOk()
        }
        let actionCancel = UIAlertAction(title: actionCancel, style: .default){ (_) in
            completionCancel()
        }
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    class func showAlertWithOk(message: String, actionOk: String,  completionOk: @escaping(() -> ())) {
        let alert = UIAlertController(title: appNameAlert, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: actionOk, style: .default) { (_) in
            completionOk()
        }
        
        alert.addAction(actionOk)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
}


extension Date {

     static func getCurrentDate() -> String {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return dateFormatter.string(from: Date())

        }
    static func getTodayDate() ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentDay() ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: Date())
    }
    
    }

extension String {

    func aesEncryptCS(key: String,iv : String) throws -> String {

        var result = ""

        do {
            let iv :[UInt8] = Array(key.utf8) as [UInt8]
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs5) // AES128 .ECB pkcs7
            let encrypted = try aes.encrypt(Array(self.utf8))

            result = encrypted.toBase64()

            print("AES Encryption Result: \(result)")

        } catch {

            print("Error: \(error)")
        }

        return result
    }

    func aesDecryptCS(key: String,iv : String) throws -> String {

        var result = ""

        do {
            let iv :[UInt8] = Array(iv.utf8) as [UInt8]
            let encrypted = self
            let key:[UInt8] = Array(key.utf8) as [UInt8]
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7) // AES128 .ECB pkcs7
            let decrypted = try aes.decrypt(Array(base64: encrypted))

            result = String(data: Data(decrypted), encoding: .utf8) ?? ""

            print("AES Decryption Result: \(result)")

        } catch {

            print("Error: \(error)")
        }

        return result
    }
}
extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
extension UINavigationController {
    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return self.viewControllers.first(where: { $0 is T })
    }
    
    func popToViewController<T: UIViewController>(of type: T.Type, animated: Bool) {
        guard let viewController = self.getViewController(of: type) else { return }
        self.popToViewController(viewController, animated: animated)
    }
}
