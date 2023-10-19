//
//  ProfileVC.swift
//  Dating
//
//  Created by Abhishek Chauhan on 06/10/23.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var imgBackBlur: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imgBackBlur.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imgBackBlur.addSubview(blurEffectView)
      
    }
    
//    func setBlurImage(){
//           let context = CIContext(options: nil)
//           let originalImage = imgBackBlur.image
//           let currentValue = Int(50)
//
//           let currentFilter = CIFilter(name: "CIGaussianBlur")
//           currentFilter!.setValue(CIImage(image: originalImage!), forKey: kCIInputImageKey)
//           currentFilter!.setValue(currentValue, forKey: kCIInputRadiusKey)
//
//           let cropFilter = CIFilter(name: "CICrop")
//           cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
//           cropFilter!.setValue(CIVector(cgRect: (CIImage(image: originalImage!)?.extent)!), forKey: "inputRectangle")
//
//           let output = currentFilter!.outputImage
//           let cgimg = context.createCGImage(output!, from: output!.extent)
//           let processedImage = UIImage(cgImage: cgimg!)
//           imgBackBlur.image = processedImage
//       }
//
    
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 1{
            print("About Me")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutMySelfVC") as! AboutMySelfVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 5{
            print("Logout")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let logoutAlert = UIAlertController(title: "Dating", message: "Are you sure! You want to Logout?", preferredStyle: UIAlertController.Style.alert)
                    logoutAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        Cookies.removeAuthorizationToken()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }))
                    
                    logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    present(logoutAlert, animated: true, completion: nil)
        }
    }
    
   
    

}
