//
//  Textfields.swift
//  HarhoApp
//
//  Created by HARSHIT on 14/03/23.
//

import Foundation
import UIKit
import UserNotifications

extension UITextField {
    func placeholderColor( _ text : String? = "" ,   color :UIColor? = .gray  ) {
        self.attributedPlaceholder = NSAttributedString(string: text!,
                                                        attributes: [NSAttributedString.Key.foregroundColor:color!])
    }
}

extension UITextField {
    func isValidEmailAddress() -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
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
    func isValidUserName() -> Bool {
        var returnValue = true
        let emailRegEx = "\\w,{3,18}(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])"
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
    
    
    func lenght() -> Bool {
        if self.text.leoSafe().count <= 0 {
              return false
            }
            return true
        }
  
    
    func isValidName() -> Bool {
        let RegEx = "^\\w{7,18}$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
    
//    func isValidUserName(text: String?): Boolean {
//        //Pattern to be followed by the username input, it has to have at least 5 characters with a maximum of 30 allowed
//        val p = Pattern.compile("^(?=.{3,30}\$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])\$")
//        //Checks if user input matches pattern type
//        val m = p.matcher(text.toString())
//        //User input allowed when it matches pattern type
//        return m.matches()
//    }
    
   
    
}

extension UITextView {
        func isEmptyy() -> Bool {
        return self.text!.trimmingCharacters(in: .whitespacesAndNewlines).count == 0
    }
    
}



extension String{
    var numberValidation: Bool {
       return NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9]).{10}$").evaluate(with: self)
     }
    
   
}
extension String{
    var isValidName: Bool {
        let RegEx = "^\\w{7,18}$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
    
}
