
import Foundation
import SwiftUI
import AWSS3
import AWSCore
let baseUrl  = "http://deploywork.com:4370/api/"    // deploye url
let imageBaseUrl = "http://harho.deploywork.com"

let accesskey = "AKIASYR7OLTQ6TQZSFF2"
let secretkey = "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"
let BucketName = "th-harho-attachments"
let regiontype =  AWSRegionType.EUWest2

var globalRoomID = ""
var groupDetailRoomID = ""
let userIDGloble = Cookies.getUserInfo()?.id

extension Api {
    func baseURl() -> String {
        return  baseUrl + self.rawValued()
    }
}

enum Api: Equatable {
    
    case signUp
    case login
    case fileUploaded
    case profileComplete
    case getMyDetail
    case changePassword
    case editProfile
    

func rawValued() -> String {
    switch self {
    case .signUp:
        return "v1/auth/sign-up"
    case .login:
        return "v1/auth/login"
    case .fileUploaded:
        return "v1/auth/file-upload"
    case .profileComplete:
        return "v1/auth/profile-complete"
    case .getMyDetail:
        return "v1/auth/get-my-detail"
    case .changePassword:
        return "v1/auth/change-passsword"
    case .editProfile:
        return "v1/auth/set-your-profile"
        
    }
}
}
        
        func isSuccess(json : [String : Any]) -> Bool{
            if let isSucess = json["code"] as? Int {
                if isSucess == 200 {
                    return true
                }
            }
            
            if let isSucess = json["code"] as? String {
                if isSucess == "200" {
                    return true
                }
            }
            if let isSucess = json["success"] as? String {
                if isSucess == "200" {
                    return true
                }
            }
            if let isSucess = json["success"] as? Int {
                if isSucess == 200 {
                    return true
                }
            }
            
            if let isSucess = json["success"] as? Bool {
                if isSucess == true {
                    return true
                }
            }
            return false
        }
        
        func message(json : [String : Any]) -> String{
            if let message = json["message"] as? String {
                return message
            }
            if let message = json["message"] as? [String:Any] {
                if let msg = message.values.first as? [String] {
                    return msg[0]
                }
            }
            if let error = json["error"] as? String {
                return error
            }
            
            return ""
        }
        
        func isBodyCount(json : [[String : Any]]) -> Int{
            return json.count
        }
        
    
    

