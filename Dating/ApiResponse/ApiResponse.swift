//
//  ApiResponse.swift
//  Dating
//
//  Created by Iram Khan on 06/10/23.
//

import Foundation
import SDWebImage
import FTIndicator

// MARK: ---SIGNUP RESPONSE---
extension RegisterVC : ResponseProtocol{
    func onSucsses(msg: String, response: [String : Any]) {
        SKActivityIndicator.dismiss()
        if msg == CustomeAlertMsg.signUp{
            let body = response["body"] as? [String:Any]
            let token = body?["token"] as? String ?? ""
            let userData = body?["user"] as? [String:Any] ?? [:]
            let role = userData["role"] as? Int ?? 0
            let id = userData["id"] as? Int ?? 0
            let name = userData["name"] as? String ?? ""
            let email = userData["email"] as? String ?? ""
            let gender = userData["gender"] as? String ?? ""
            let dob = userData["dob"] as? String ?? ""
            let password = userData["password"] as? String ?? ""
            UserDefaults.standard.setValue(id, forKey: UserDefaultKey.id)
            UserDefaults.standard.setValue(email, forKey: UserDefaultKey.email)
            UserDefaults.standard.setValue(name, forKey: UserDefaultKey.name)
            UserDefaults.standard.setValue(token, forKey: UserDefaultKey.authorizationToken)
            Cookies.saveAuthorizationToken(token: token)
            Cookies.saveUserInfo(dict: userData)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSetupVC") as! ProfileSetupVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        }
    func onFailure(msg: String) {
        print(msg)
        SKActivityIndicator.dismiss()
        FTIndicator.showToastMessage(msg)
        
    }
}

// MARK: ---LOGIN RESPONSE---
extension LoginVC : ResponseProtocol{
    func onSucsses(msg: String, response: [String : Any]) {
        SKActivityIndicator.dismiss()
        if msg == CustomeAlertMsg.Login{
            let body = response["body"] as? [String:Any]
            let token = body?["token"] as? String ?? ""
            let userData = body?["user"] as? [String:Any] ?? [:]
           
            Cookies.saveAuthorizationToken(token: token)
            Cookies.saveUserInfo(dict: userData)
            self.model.getMyDetailApi()
            
        }else if msg == CustomeAlertMsg.getMyDetail{
            let body = response["body"] as? [String:Any]
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(getMyDetailModel.self, from: jsondata)
                self.getMyDetailModelData = encodedJson
                let profileComplete = self.getMyDetailModelData?.is_profile_complete ?? 0
                if profileComplete == 1{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                // UserDefaults.standard.set(profileComplete, forKey: UserDefaultKey.is_profile_complete)
            } catch{
                print(error)
            }
        }
        
    }
    
    func onFailure(msg: String) {
        print(msg)
        SKActivityIndicator.dismiss()
        FTIndicator.showToastMessage(msg)
        
    }
}
// MARK: ---Profile Setup---
extension ProfileSetupVC : ResponseProtocol{
    func onSucsses(msg: String, response: [String : Any]) {
        SKActivityIndicator.dismiss()
        if msg == CustomeAlertMsg.fileUploaded{
            let body = response["body"] as? [String]
          //  Cookies.saveUserInfo(dict: body)
            UserDefaults.standard.setValue(body, forKey: UserDefaultKey.body)
            UserDefaults.standard.stringArray(forKey: UserDefaultKey.body)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
            vc.productImage = self.productImage
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func onFailure(msg: String) {
        print(msg)
        SKActivityIndicator.dismiss()
        FTIndicator.showToastMessage(msg)
        
    }
}

// MARK: ---Update Profile---
extension UpdateProfileVC : ResponseProtocol{
    func onSucsses(msg: String, response: [String : Any]) {
        SKActivityIndicator.dismiss()
        if msg == CustomeAlertMsg.profileComplete{
            let body = response["body"] as? [String:Any]
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(updateProfileModel.self, from: jsondata)
                self.updateProfileModelData = encodedJson
                self.model.getMyDetailApi()
            } catch{
                print(error)
            }
        }else if msg == CustomeAlertMsg.getMyDetail{
            let body = response["body"] as? [String:Any]
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(getMyDetailModel.self, from: jsondata)
                self.getMyDetailModelData = encodedJson
                let profileComplete = self.getMyDetailModelData?.is_profile_complete ?? 0
                 UserDefaults.standard.set(profileComplete, forKey: UserDefaultKey.is_profile_complete)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverVC") as! DiscoverVC
                self.navigationController?.pushViewController(vc, animated: true)
            } catch{
                print(error)
            }
        }
        
    }
    
    func onFailure(msg: String) {
        print(msg)
        SKActivityIndicator.dismiss()
        FTIndicator.showToastMessage(msg)
        
    }
}
// MARK: ---GetMy Detail---
extension AboutMySelfVC : ResponseProtocol{
    func onSucsses(msg: String, response: [String : Any]) {
        SKActivityIndicator.dismiss()
        if msg == CustomeAlertMsg.getMyDetail{
            let body = response["body"] as? [String:Any]
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(getMyDetailModel.self, from: jsondata)
                self.getMyDetailModelData = encodedJson
                self.lblName.text = self.getMyDetailModelData?.name ?? ""
                self.lblEmail.text = self.getMyDetailModelData?.email ?? ""
                self.lblAbout.text = self.getMyDetailModelData?.about_us ?? ""
                self.lblHeight.text = self.getMyDetailModelData?.height ?? ""
                self.lblWeight.text = self.getMyDetailModelData?.weight ?? ""
                self.lblInterest.text = self.getMyDetailModelData?.interest ?? ""
                self.lblLocation.text = self.getMyDetailModelData?.location ?? ""
                let profileComplete = self.getMyDetailModelData?.is_profile_complete ?? 0
                UserDefaults.standard.set(profileComplete, forKey: UserDefaultKey.is_profile_complete)
            } catch{
                print(error)
            }
        }
        
    }
    
    func onFailure(msg: String) {
        print(msg)
        SKActivityIndicator.dismiss()
        FTIndicator.showToastMessage(msg)
        
    }
}
// MARK: ---Password Change---
extension ChangePasswordVC : ResponseProtocol{
    func onSucsses(msg: String, response: [String : Any]) {
        SKActivityIndicator.dismiss()
        if msg == CustomeAlertMsg.changePassword{
            let body = response["body"] as? [String]
          //  Cookies.saveUserInfo(dict: body)
            dismiss(animated: true)
        }
        
    }
    
    func onFailure(msg: String) {
        print(msg)
        SKActivityIndicator.dismiss()
        FTIndicator.showToastMessage(msg)
        
    }
}
// MARK: ---Edit Profile---
extension EditProfileVC : ResponseProtocol{
    func onSucsses(msg: String, response: [String : Any]) {
        SKActivityIndicator.dismiss()
        if msg == CustomeAlertMsg.editProfile{
            let body = response["body"] as? [String]
          //  Cookies.saveUserInfo(dict: body)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutMySelfVC") as! AboutMySelfVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func onFailure(msg: String) {
        print(msg)
        SKActivityIndicator.dismiss()
        FTIndicator.showToastMessage(msg)
        
    }
}
