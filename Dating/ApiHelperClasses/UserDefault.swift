//
//  UserDefault.swift
//  HarhoApp
//
//  Created by HARSHIT on 23/03/23.
//

import Foundation


extension NSDictionary {
    var age : String {
        return self["age"] as? String ?? ""
    }
    var role : Int{
        return self["role"] as? Int ?? 0
    }
    var name : String{
        return self["name"] as? String ?? ""
    }
    var email : String{
        return self["email"] as? String ?? ""
    }
    var gender : Int{
        return self["gender"] as? Int ?? 0
    }
    var id : Int{
        return self["id"] as? Int ?? 0
    }
    var dob : String{
        return self["dob"] as? String ?? ""
    }
    var is_profile_complete : Int{
        return self["is_profile_complete"] as? Int ?? 0
    }
    var location : String{
        return self["location"] as? String ?? ""
    }
    var latitude : String{
        return self["latitude"] as? String ?? ""
    }
    var longitude : String{
        return self["longitude"] as? String ?? ""
    }
    var height : String{
        return self["height"] as? String ?? ""
    }
    var weight : String{
        return self["weight"] as? String ?? ""
    }
    var interest : String{
        return self["interest"] as? String ?? ""
    }
    var about_us : String{
        return self["about_us"] as? String ?? ""
    }
   
 

   
}

class Cookies {
    
    class func saveUserInfo(dict : [String : Any]? = nil){
        let keyData = NSKeyedArchiver.archivedData(withRootObject: dict as Any)
        UserDefaults.standard.set(keyData, forKey: "userInfoSave")
        UserDefaults.standard.synchronize()
    }
    

    class func getUserInfo() -> NSDictionary? {
        if let some =  UserDefaults.standard.object(forKey: "userInfoSave") as? NSData {
            if let dict = NSKeyedUnarchiver.unarchiveObject(with: some as Data) as? NSDictionary {
                return dict
            }
        }
        return nil
    }
    class func deleteUserInfo() {
        UserDefaults.standard.removeObject(forKey: "userInfoSave")
    }
    
    class func saveAuthorizationToken(token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultKey.authorizationToken)
    }
    
    class func removeAuthorizationToken() {
        UserDefaults.standard.set("", forKey: UserDefaultKey.authorizationToken)
    }
    class func getAuthorizationToken() -> String {
      let token = UserDefaults.standard.string(forKey: UserDefaultKey.authorizationToken) ?? ""
       return token
    }
    class func getDeviceToken() -> String {
      let deviceToken = UserDefaults.standard.string(forKey: UserDefaultKey.deviceToken) ?? ""
       return deviceToken
    }
    
    
//    class func saveUserID(id:String){
//        UserDefaults.standard.set(id, forKey: UserDefaultKey.UserID)
//    }
//    class func removeUserID() {
//        UserDefaults.standard.set("", forKey: UserDefaultKey.UserID)
//    }
//    class func getUserID() -> String {
//      let token = UserDefaults.standard.string(forKey: UserDefaultKey.UserID) ?? ""
//       return token
//    }
//    class func saveUserName(id:String){
//        UserDefaults.standard.set(id, forKey: UserDefaultKey.UserName)
//    }
//    class func removeUsername() {
//        UserDefaults.standard.set("", forKey: UserDefaultKey.UserName)
//    }
//    class func getUserName() -> String {
//      let token = UserDefaults.standard.string(forKey: UserDefaultKey.UserName) ?? ""
//       return token
//    }

    class func saveDeviceToken(token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultKey.deviceToken)
    }
    

}

var currentAccessToken :String? {
    get {
        return  UserDefaults.standard.currentAccessToken()
    }
    set {
        UserDefaults.standard.currentAccessToken(newValue)
    }
}



extension UserDefaults {

    /// Private key for persisting the active Theme in UserDefaults
    private static let currentAccessTokenKey = "AuthToken"

    /// Retreive theme identifer from UserDefaults
    public func currentAccessToken() -> String? {
        return self.string(forKey: UserDefaults.currentAccessTokenKey)
    }

    /// Save theme identifer to UserDefaults
    public func currentAccessToken(_ identifier: String?) {
        self.set(identifier, forKey: UserDefaults.currentAccessTokenKey)
    }

}
