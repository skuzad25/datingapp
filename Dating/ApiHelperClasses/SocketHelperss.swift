////
//////  SocketHelperss.swift
//////  FAF
//////
//////  Created by tech on 09/09/21.
////
//
//import UIKit
//import Foundation
//import SwiftyJSON
//
////let kHost = "http://harho.deploywork.com:4357/" //staging
////let kHost = "http://harho.deploywork.com:4357/" //live
//
//let data = Cookies.getUserInfo()
//
//
//final class SocketHelperss: NSObject {
//
//    static let shared = SocketHelperss()
//
//    private var manager: SocketManager?
//    private var socket: SocketIOClient?
//
//    override init() {
//        super.init()
//        configureSocketClient()
//    }
//
//    private func configureSocketClient() {
//      
//        guard let url = URL(string: baseUrl.replacingOccurrences(of: "api/v1", with: "")) else {
//            return
//        }
//
//        manager = SocketManager(socketURL: url, config: [.log(false), .compress])
//
//
//        guard let manager = manager else {
//            return
//        }
//
//        socket = manager.socket(forNamespace: "/")
//    }
//
//    func establishConnection() {
//        guard let socket = manager?.defaultSocket else{
//            return
//        }
//
//        socket.connect()
//        print("Socket is connected")
//    }
//
//    func closeConnection() {
//
//        guard let socket = manager?.defaultSocket else{
//            return
//        }
//
//        socket.disconnect()
//        print("Socket is disconnected")
//    }
//
//
//}
//
//extension UIApplication {
//
//    static func jsonString(from object:Any) -> String? {
//
//        guard let data = jsonData(from: object) else {
//            return nil
//        }
//
//        return String(data: data, encoding: String.Encoding.utf8)
//    }
//
//    static func jsonData(from object:Any) -> Data? {
//
//        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
//            return nil
//        }
//
//        return data
//    }
//}
//
//
//
//extension SocketHelperss{
//
//    func onleaderBoard(completion: @escaping (_ leaderBoard: Bool?) -> Void) {
////         var modelData = [UserModel]()
//        guard let socket = manager?.defaultSocket else {
//            return
//        }
//        print("outinside")
//        socket.on("leaderBoards"){ [weak self] (result, ack) -> Void in
//            print("inside")
//            completion(true)
//        }
//    }
//    func onTrackTime(completion: @escaping (_ messageInfo: Bool?) -> Void) {
//
//        guard let socket = manager?.defaultSocket else {
//            return
//        }
//        print("outinside")
//        socket.on("appTimeSocket") { (dataArray, socketAck) -> Void in
//            print("inside")
//            completion(true)
//
//        }
////        socket.on("appTimeSocket\(user_id)") { (dataArray, socketAck) -> Void in
////            print("inside")
////            completion(true)
////
////        }
//    }
//    func emitTime(user_id: Int, completion: () -> Void) {
//
//        guard let socket = manager?.defaultSocket else {
//            return
//        }
//        let param = [ "user_id":user_id]
//        socket.emit("appTimeSocket",param)
//        completion()
//    }
////    func onVideoCall(user_id:String,completion: @escaping (_ messageInfo: Bool?) -> Void) {
////
////        guard let socket = manager?.defaultSocket else {
////            return
////        }
////        print("outinside")
////        socket.on("appTimeSocket") { (dataArray, socketAck) -> Void in
////            print("inside")
////            completion(true)
////
////        }
//////        socket.on("appTimeSocket\(user_id)") { (dataArray, socketAck) -> Void in
//////            print("inside")
//////            completion(true)
//////
//////        }
////    }
//
//
//}
