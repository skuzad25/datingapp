//
//  MainViewModel.swift
//  Dating
//
//  Created by Iram Khan on 06/10/23.
//

import Foundation
import UIKit

class MainViewModel{
    var delegate: ResponseProtocol?
    
    // MARK:  -----SignUp API----
    func signUpApiCalling(param:[String:Any]){
        APIClient.postAuth(url: .signUp, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false){
            (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: CustomeAlertMsg.signUp, response: response)
            }else{
                self.delegate?.onFailure(msg: response["message"]  as? String ?? "")
            }
        } failureHandler: { (response) in
            print(response)
            if let msg = response["error"] as? String{
                self.delegate?.onFailure(msg: msg)
            }
        }
    }
    
    // MARK:  -----Login API----
    func loginApiCalling(param:[String:Any]){
        APIClient.postAuth(url: .login, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false){
            (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: CustomeAlertMsg.Login, response: response)
            }else{
                self.delegate?.onFailure(msg: response["message"]  as? String ?? "")
            }
        } failureHandler: { (response) in
            print(response)
            if let msg = response["error"] as? String{
                self.delegate?.onFailure(msg: msg)
            }
        }
    }
    //MARK: ---ProfilePic Uploaded---
    func uploadImage(param:[String:Any],images: [UIImage]){
         APIClient.postMultiPartAuth5(url: .fileUploaded
                                      , jsonObject: [:], files: images, key: "image", authorizationToken: true, refreshToken: false){
             (response) in
             print(response)
             if isSuccess(json: response){
                 self.delegate?.onSucsses(msg: CustomeAlertMsg.fileUploaded, response: response)
             }else{
                 self.delegate?.onFailure(msg: response["message"]  as? String ?? "")
             }
         } failureHandler: { (response) in
             print(response)
             if let msg = response["error"] as? String{
                 self.delegate?.onFailure(msg: msg)
             }
         }
     }
    
    //MARK: ---Profile Complete---
    func profileCompleteApi(param:[String:Any]){
        APIClient.postAuth(url: .profileComplete, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true){
            (response) in
             print(response)
             if isSuccess(json: response){
                 self.delegate?.onSucsses(msg: CustomeAlertMsg.profileComplete, response: response)
             }else{
                 self.delegate?.onFailure(msg: response["message"]  as? String ?? "")
             }
         } failureHandler: { (response) in
             print(response)
             if let msg = response["error"] as? String{
                 self.delegate?.onFailure(msg: msg)
             }
         }
     }
    
    //MARK: ----Get My Detail----
    func getMyDetailApi(){
        APIClient.postAuth(url: .getMyDetail, parameters: [:], method: .get, contentType: .applicationJson, authorizationToken: true, refreshToken: false){
            (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: CustomeAlertMsg.getMyDetail, response: response)
            }else{
                self.delegate?.onFailure(msg: response["message"]  as? String ?? "")
            }
        } failureHandler: { (response) in
            print(response)
            if let msg = response["error"] as? String{
                self.delegate?.onFailure(msg: msg)
            }
        }
    }
    //MARK: ---Change Password---
    func changePasswordApi(param:[String:Any]){
        APIClient.postAuth(url: .changePassword, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true){
            (response) in
             print(response)
             if isSuccess(json: response){
                 self.delegate?.onSucsses(msg: CustomeAlertMsg.changePassword, response: response)
             }else{
                 self.delegate?.onFailure(msg: response["message"]  as? String ?? "")
             }
         } failureHandler: { (response) in
             print(response)
             if let msg = response["error"] as? String{
                 self.delegate?.onFailure(msg: msg)
             }
         }
     }
    //MARK: ---EditnProfile---
    func editProfileApi(param:[String:Any]){
        APIClient.postAuth(url: .editProfile, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true){
            (response) in
             print(response)
             if isSuccess(json: response){
                 self.delegate?.onSucsses(msg: CustomeAlertMsg.editProfile, response: response)
             }else{
                 self.delegate?.onFailure(msg: response["message"]  as? String ?? "")
             }
         } failureHandler: { (response) in
             print(response)
             if let msg = response["error"] as? String{
                 self.delegate?.onFailure(msg: msg)
             }
         }
     }
    
}


