//
//   KeychainUTL.swift
//  HarhoApp
//
//  Created by HARSHIT on 23/03/23.
//

import Foundation
import Security


class KeyChain {

    class func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
}

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
class KeychainAccess:NSObject{
    func getDataFromKeyChainFunction() {
                   let uniqueID = KeyChain.createUniqueID()
                   let data = uniqueID.data(using: String.Encoding.utf8)
                   let status = KeyChain.save(key: "uniqueID", data: data!)
                   if let udid = KeyChain.load(key: "uniqueID") {
                       let uniqueID = String(data: udid, encoding: String.Encoding.utf8)
                       print(uniqueID!)
                   }
                  }
           func save(key: String, data: Data) -> OSStatus {
                   let query = [
                       kSecClass as String       : kSecClassGenericPassword as String,
                       kSecAttrAccount as String : key,
                       kSecValueData as String   : data ] as [String : Any]
                   SecItemDelete(query as CFDictionary)
                   return SecItemAdd(query as CFDictionary, nil)
           }
           func checkUniqueID() -> String {
               if let udid = KeyChain.load(key: "uniqueID") {
                   let uniqueID = String(data: udid, encoding: String.Encoding.utf8)
                   print(uniqueID!)
                return uniqueID!
               } else {
                   let uniqueID = KeyChain.createUniqueID()
                   let data = uniqueID.data(using: String.Encoding.utf8)
                   let status = KeyChain.save(key: "uniqueID", data: data!)
                   print("status: ", status)
                return uniqueID
               }
           }
}
//let int: Int = 555
//let data = Data(from: int)
//let status = KeyChain.save(key: "MyNumber", data: data)
//print("status: ", status)
//
//if let receivedData = KeyChain.load(key: "MyNumber") {
//    let result = receivedData.to(type: Int.self)
//    print("result: ", result)
//}
 
