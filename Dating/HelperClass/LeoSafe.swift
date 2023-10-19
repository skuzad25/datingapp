//
//  LeoSafe.swift
//  HarhoApp
//
//  Created by HARSHIT on 14/03/23.
//

import Foundation
import UIKit

//https://medium.com/ios-os-x-development/handling-empty-optional-strings-in-swift-ba77ef627d74
extension Optional where Wrapped == String {
    func leoSafe(defaultValue : String? = "") -> String {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf.isEmpty ? defaultValue! : strongSelf
    }
}
extension Optional where Wrapped == Int {
    
    func leoSafe(defaultValue : Int? = 0 ) -> Int {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf
    }
}

extension Optional where Wrapped == Bool {
    
    func leoSafe(defaultValue : Bool? = false ) -> Bool {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf
    }
}

