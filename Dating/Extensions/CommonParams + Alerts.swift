//
//  UIViewControllerExtention.swift
//  SportxUser
//
//  Created by Abhishek Chauhan on 19/07/23.
//

import Foundation
import UIKit


struct AlertsMessage {
    static let enterName = "Please enter name"
    static let enterEmail = "Please enter email"
    static let validEmail = "Please enter valid email"
    static let enterPassword = "Please enter password"
    static let validPassword = "Please enter valid password"
    static let enterNewPassword = "Please enter new password"
    static let enterOldPassword = "Please enter old password"
    static let enterConfirmPassword = "Please enter confirm password"
    static let enterSamePassword = "Please enter password and confirm password same"
    static let selectTermConditions = "Please aceept all terms & conditions "
    static let someThingWentWorng = "SomeThing went wrong"
  
    
    
}
struct CustomeAlertMsg {
    static let creteAccount = "Account Created Succesfully"
    static let Login = "Login Successfull"
    static let signUp = "User registered successfully"
    static let emailOtp = "emailOtp Verification Successfull"
    static let forgotPassword = "OTP sent successfully"
    static let updatePassword = "Password Updated successfully"
    static let mobileSignUp = "Mobile signup successfull"
    static let resendOtp = "OTP resent successfully"
    static let fileUploaded = "Profile Pic Uploaded successfully"
    static let profileComplete = "Profile Completed successfully"
    static let getMyDetail = "Get my detail successfully"
    static let changePassword = "Password change successfully"
    static let editProfile = "Profile Edit successfully"
    
}
struct ApiParams {
    
    static let email = "email"
    static let name = "name"
    static let gender = "gender"
    static let dob = "dob"
    static let password = "password"
    static let error = "error"
    static let location = "location"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let height = "height"
    static let weight = "weight"
    static let interest = "interest"
    static let about_us = "about_us"
    static let profileimgArr = "profileimgArr"
    static let oldPassword = "oldPassword"
    static let newPassword = "newPassword"
    
}


struct UserDefaultKey {
    static let authorizationToken = "authorizationToken"
    static let deviceToken = "deviceToken"
    static let id = "id"
    static let email = "email"
    static let name = "name"
    static let kUserToken = "token"
    static let body = "body"
    static let is_profile_complete = "is_profile_complete"
    
    
    }
