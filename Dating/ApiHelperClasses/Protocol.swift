//
//  Protocol.swift
//  HarhoApp
//
//  Created by HARSHIT on 23/03/23.
//

import Foundation


protocol ResponseProtocol {
    func onSucsses(msg:String,response:[String:Any])
    func onFailure(msg :String)
}
    
protocol ErrorMsg {
    func showErrorPopup()
}
