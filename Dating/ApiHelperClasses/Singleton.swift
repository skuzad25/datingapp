//
//  Singleton.swift
//  NameCard
//
//  Created by PARAS on 05/10/22.
//

import Foundation
import UIKit
var Shared : Singleton = Singleton()
class Singleton: NSObject {
    
    var window: UIWindow?
    
    
    //Gallery images fetched saved
    var fetchResults = [UIImage]()

    //selected images send on chat
    var selectedImagesIndex : [Int] = []
    var selectedImagess : [UIImage] = []
    var createdRoomIds : [String] = []
    var ComingImages : [UIImage] = []
    
    //Hidden Chat Status
    var hidden: Bool = false

    var first: Bool = false
    
    var cardAdd: Bool = false

    var isFromBack : Bool = false
    var innerChatVC: Bool = false
    var login: Bool = false
    var appendMessageList = [[String:Any]]()
    var selectedMembers = [[String:Any]]()
    var type = ""
    
    class var sharedInstance : Singleton {
        return Shared
    }
}
