//
//  RefreshToken.swift
//  WorkPlace
//
//  Created by tech on 24/02/21.
//

import Foundation
import UIKit
import Alamofire
import FTIndicator

typealias CompletionBlock = ([String : Any]) -> Void
typealias FailureBlock = ([String : Any]) -> Void
typealias ProgressBlock = (Double) -> Void

struct APIClient {
    
    enum ContentType : String {
        case applicationJson = "application/json"
        case textPlain = "text/plain"
        case form = "application/x-www-form-urlencoded"
    }
    
    static var manager = Alamofire.SessionManager.default
    
    static func uploadFiles(url: Api, jsonObject: [String : Any], files: (key: String, path: [URL]), completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
        
        let urlString = url.baseURl()
        let parameters: Parameters = jsonObject
        print("******URL*****\(urlString) *****Parameters*****\(parameters)")
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (_ , file) in files.path.enumerated() {
                let directoryName = ""
                var url = URL(fileURLWithPath: directoryName)
                let filename = file
                url = url.appendingPathComponent(filename.absoluteString)
                
                
                let filePath = url.absoluteString.replacingOccurrences(of: "file:/", with: "")
                
                print("FILE EXISTANCE STATUS 1 : \(FileManager.default.fileExists(atPath: filePath))")
                
                if FileManager.default.fileExists(atPath: filePath) {
                    
                    print(file.absoluteString)
                    print(file.pathExtension)
                    
                    
                    if url.pathExtension == "jpg" {
                        // Image)
                        
                        if let profiePic =  UIImage(contentsOfFile: filePath) {
                            let data = profiePic.jpegData(compressionQuality: 0.5)
                            
                            multipartFormData.append(data!, withName: files.key, fileName: file.lastPathComponent, mimeType: "image/\(file.pathExtension)")
                            
                        }
                    }else {
                        // Document
                        
                        let docPaths = url.path.components(separatedBy: "/Users/tech/")
                        
                        do {
                            let documentData = try Data(contentsOf: file)
                            multipartFormData.append(documentData, withName: files.key, fileName: file.lastPathComponent, mimeType: "application/\(file.pathExtension)")
                        }
                        catch {
                            print("Error : \(error.localizedDescription)")
                        }
                    }
                }
            }
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },
                         to: urlString) { result  in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { _ in
                    // Print progress
                    
                })
                upload.responseJSON { response in
                    switch (response.result) {
                    case .success(let value):
                        
                        print("********ddf*" , value)
                        
                        completionHandler!(value as! [String : Any] )
                    case .failure(let error):
                        print(error)
                        failureHandler?([:] )
                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
            
        }
    }
    
    static func uploadMultiImages(url: Api, jsonObject: [String : Any], files: [Any], completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
        var headers = HTTPHeaders()
        var authorizationTokens = Cookies.getAuthorizationToken()
        let boundary = "Boundary-\(UUID().uuidString)"

        headers["Authorization"] = "Bearer \(authorizationTokens)"
//        headers["Content-Type"] = "multipart/form-data; boundary=\(boundary)"

//        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let urlString = url.baseURl()
        let parameters: Parameters = jsonObject
        print("******URL*****\(urlString) *****Parameters*****\(parameters)")
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for id in files{
                
                let image = id as? UIImage
                if image == nil{
                    let file = (id as? URL)

                    multipartFormData.append(file!, withName: "url", fileName:"file", mimeType: "Documents/pdf")

                }else{
                    let data = image?.jpegData(compressionQuality: 0.5)
                    multipartFormData.append(data!, withName: "url", fileName:"\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")

                }
              
            }
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },
                         to: urlString, headers: headers) { result  in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { _ in
                    // Print progress
                    
                })
                upload.responseJSON { response in
                    switch (response.result) {
                    case .success(let value):
                        
                        print("********ddf*" , value)
                        
                        completionHandler!(value as! [String : Any] )
                    case .failure(let error):
                        print(error)
                        failureHandler?([:] )
                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
            
        }
    }
    static func postMultiPartAuth5( url : Api,jsonObject: [String : Any] , files :[Any] ,key : String?, authorizationToken : Bool?  = nil,refreshToken : Bool?  = nil, completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
            
            var headers = HTTPHeaders()
            
        var authorizationTokens = Cookies.getAuthorizationToken()
        let boundary = "Boundary-\(UUID().uuidString)"

        headers["Authorization"] = "Bearer \(authorizationTokens)"

            
            let urlString = url.baseURl()
        
            let parameters: Parameters = jsonObject
            print("******URL*****\(urlString) *****Parameters*****\(parameters)")
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                for ((index , file)) in files.enumerated() {
                    
                    if ((file as? UIImage) != nil) {
                            let data = (file as? UIImage)?.jpegData(compressionQuality: 0.5)
                        multipartFormData.append(data!, withName: key ?? "", fileName:"\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")
                    } else  {
                        
    //                    let dd = (file as! URL).absoluteString.replacingOccurrences(of: "m4a/", with: "mp3")
                        
                        let url = file as! URL
                                       

                        if url.lastPathComponent == ".MOV" {
                            multipartFormData.append(url, withName: key ?? "", fileName: "\(NSUUID().uuidString).mp4", mimeType: "video/mp4")
                                  
                        }else if url.lastPathComponent == ".mp3" || url.pathExtension == ".m4a" {

                            multipartFormData.append(url.absoluteURL, withName: key ?? "", fileName: "\(NSUUID().uuidString).mp3", mimeType: "audio/mp3")
                        
                            }else{
                                multipartFormData.append(url.absoluteURL, withName: key ?? "", fileName: "\(NSUUID().uuidString).\(url.pathExtension ?? "")", mimeType: "doc/pdf")
                                }
                    }
                }
                
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
                
            },
            to: urlString, headers: headers) { result  in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { _ in
                        // Print progress
                        
                    })
                    
                    upload.responseJSON { response in
                        switch (response.result) {
                        case .success(let value):
                            
                            print("********ddf*" , value)
                            
                            if let responseData = value as? [String:Any]{
                                if let successCode = responseData["success"] as? Int{
                                    if successCode == 407{
       
                                        let error = ["Param.error": "Something went wrong" ]
                                            failureHandler?(error)

                                    }else{
                                        completionHandler!(value as! [String : Any] )
                                    }
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            let error = ["message":error.localizedDescription ]
                            failureHandler?(error )
                        }
                        
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
                
            }
        }
    
 static func postMultiPartAuth( url : Api,jsonObject: [String : Any] , files :[Any] ,key : String?,files2 : [Any],key2 : String?, authorizationToken : Bool?  = nil,refreshToken : Bool?  = nil, completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
        
        var headers = HTTPHeaders()
        var authorizationTokens = Cookies.getAuthorizationToken()
        if refreshToken == true{
            headers["Authorization"] = "Bearer \(authorizationTokens)"
        }else{
            if authorizationToken == true{
                headers["Authorization"] = "Bearer \(authorizationTokens)"
            }
        }
        
        let urlString = url.baseURl()
        
        let parameters: Parameters = jsonObject
        print("******URL*****\(urlString) *****Parameters*****\(parameters)")
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (index , file) in files.enumerated() {
                
                if ((file as? UIImage) != nil) {
                    let data = (file as? UIImage)?.jpegData(compressionQuality: 0.5)
                    multipartFormData.append(data!, withName: key ?? "", fileName:"\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")
                } else  {
                    
                    //                    let dd = (file as! URL).absoluteString.replacingOccurrences(of: "m4a/", with: "mp3")
                    
                    let url = file as! URL
                    
                    
                    if url.lastPathComponent == ".MOV" {
                        multipartFormData.append(url, withName: key ?? "", fileName: "\(NSUUID().uuidString).mp4", mimeType: "video/mp4")
                        
                    }else if url.lastPathComponent == ".mp3" || url.pathExtension == ".m4a" {
                        
                        multipartFormData.append(url.absoluteURL, withName: key ?? "", fileName: "\(NSUUID().uuidString).mp3", mimeType: "audio/mp3")
                        
                    }else{
                        multipartFormData.append(url.absoluteURL, withName: key ?? "", fileName: "\(NSUUID().uuidString).\(url.pathExtension ?? "")", mimeType: "doc/pdf")
                    }
                }
            }
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },
                         to: urlString, headers: headers) { result  in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { _ in
                    // Print progress
                    
                })
                
                upload.responseJSON { response in
                    switch (response.result) {
                    case .success(let value):
                        
                        print("********ddf*" , value)
                        
                        if let responseData = value as? [String:Any]{
                            if let successCode = responseData["success"] as? Int{
                                if successCode == 407{
                                    
                                    let error = [ApiParams.error: "Something went wrong" ]
                                    failureHandler?(error)
                                    
                                }else{
                                    completionHandler!(value as! [String : Any] )
                                }
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        //                SKActivityIndicator.dismiss()
                        if error._code == NSURLErrorTimedOut {
                            //                                let error = ["message":error.localizedDescription ]
                            //                                failureHandler?(error )
                            
                            FTIndicator.showToastMessage("Request timeout!")
                            print("ERRROR:  Request timeout!")
                        }
                        if error._code == NSURLErrorNetworkConnectionLost {
                            print("ERRROR:  Connection Lost!")
                            FTIndicator.showToastMessage("Connection Lost!")
                        }
                        if error._code == NSURLErrorNotConnectedToInternet {
                            print("ERRROR:  Internet not avialable")
                            FTIndicator.showToastMessage("Internet not avialable")
                        }
                        if error._code == NSURLErrorCannotConnectToHost {
                            print("ERRROR:  Could not connect to the server")
                            FTIndicator.showToastMessage("Could not connect to the server")
                        }
                    }
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                //                SKActivityIndicator.dismiss()
                if error._code == NSURLErrorTimedOut {
                    //                                let error = ["message":error.localizedDescription ]
                    //                                failureHandler?(error )
                    
                    FTIndicator.showToastMessage("Request timeout!")
                    print("ERRROR:  Request timeout!")
                }
                if error._code == NSURLErrorNetworkConnectionLost {
                    print("ERRROR:  Connection Lost!")
                    FTIndicator.showToastMessage("Connection Lost!")
                }
                if error._code == NSURLErrorNotConnectedToInternet {
                    print("ERRROR:  Internet not avialable")
                    FTIndicator.showToastMessage("Internet not avialable")
                }
                if error._code == NSURLErrorCannotConnectToHost {
                    print("ERRROR:  Could not connect to the server")
                    FTIndicator.showToastMessage("Could not connect to the server")
                }
            }
            
        }
        
    }
        
    static func postAuth( url : Api,
                        parameters  : [String : Any]  ,
                        method : HTTPMethod? = .get ,
                        contentType: ContentType? = .applicationJson,
                        authorization : (user: String, password: String)? = nil,
                        authorizationToken : Bool?  = nil,refreshToken : Bool?  = nil,
                        completionHandler: CompletionBlock? = nil,
                          failureHandler: FailureBlock? = nil){
    
        
        if UserDefaults.standard.string(forKey: "InernetStatus") == "Off"{
            SKActivityIndicator.dismiss()
            FTIndicator.showToastMessage("Please Check Internet Connectivity.")
            return
        }
        
        
        var headers : HTTPHeaders = [
            "Content-Type": "application/json",
            "cache-control": "no-cache"
        ]
        
        
        if contentType! == .applicationJson {
            if authorization != nil {
                if let authorization1 = authorization {
                    if let authorizationHeader = Request.authorizationHeader(user: authorization1.user, password: authorization1.password) {
                        headers[authorizationHeader.key] = authorizationHeader.value
                    }
                }
            }
        }
        
        var authorizationTokens = Cookies.getAuthorizationToken()
        if refreshToken == true{
            headers["Authorization"] = "Bearer \(authorizationTokens)"
        }else{
            if authorizationToken == true{
                headers["Authorization"] = "Bearer \(authorizationTokens)"
            }
        }
//        headers["Content-Type"] = "application/json"


        
        let urlString = url.baseURl()
        print("******URL*****\(urlString) *****Parameters*****\(parameters)")
        var somString = ""
        
        let dictionary = parameters
        
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: dictionary,
            options: .prettyPrinted
        ), let theJSONText = String(data: theJSONData,
                                    encoding: String.Encoding.utf8) {
            somString = theJSONText
        }
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.fittingroom.newtimezone.Fitzz")
        configuration.timeoutIntervalForRequest = 20
        APIClient.manager = Alamofire.SessionManager(configuration: configuration)
        
        var encodeSting : ParameterEncoding = somString
        
        if method == .get {
            encodeSting = URLEncoding.default
        }
//
        Alamofire.request(urlString, method: method!,parameters: parameters,encoding:encodeSting ,  headers:headers  )
            .responseJSON { response in
                
                switch (response.result) {
                case .success(let value):
                    if let responseData = value as? [String:Any]{
                        if let successCode = responseData["success"] as? Int{
                            if successCode == 498{
                                let error = [ApiParams.error:AlertsMessage.someThingWentWorng ]
                                failureHandler?(error)
                            }else{
                                completionHandler!(value as! [String : Any] )
                            }
                        }
                    }
                case .failure(let error):
                    SKActivityIndicator.dismiss()
                    print("Error--",error.localizedDescription)
                    if error._code == NSURLErrorTimedOut {
                        FTIndicator.showToastMessage("Request timeout!")
                        print("ERRROR:  Request timeout!")
                    }
                    if error._code == NSURLErrorNetworkConnectionLost {
                        print("ERRROR:  Connection Lost!")
                        FTIndicator.showToastMessage("Connection Lost!")
                    }
                    if error._code == NSURLErrorNotConnectedToInternet {
                        print("ERRROR:  Internet not avialable")
                        failureHandler?([ApiParams.error:"Internet not avialable"])
                        FTIndicator.showToastMessage("Internet not avialable")
                    }
                    if error._code == NSURLErrorCannotConnectToHost {
                        print("ERRROR:  Could not connect to the server")
                        FTIndicator.showToastMessage("Could not connect to the server")
                    }
                }
            }
    }

    
//    //MARK: ****************ALAMOFIRE POST REQUEST********************
//    func AFPostRequest(url:Api,parameters:[String : Any],authorizationToken : Bool?  = nil,    completionHandler: CompletionBlock? = nil,
//                       failureHandler: FailureBlock? = nil) {//Session Expired
//        if !NetworkState.isConnected(){
////            SKActivityIndicator.dismiss()
//            FTIndicator.showToastMessage("Please Check Internet Connectivity.")
//        }
//        print(url,parameters)
//        var headers : HTTPHeaders = [:]
//        if authorizationToken == true{
//            headers["Authorization"] = "Bearer \(UserDefaults.standard.value(forKey: UserDefaultKey.kUserToken) ?? "")"
//        }
//        let manager = AF
//        manager.session.configuration.timeoutIntervalForRequest = 20
//        manager.request(url as! URLConvertible,method: .post,parameters:parameters,encoding: URLEncoding.httpBody,headers:headers).responseDecodable { response in
//            switch (response.result) {
//            case .success(let value): // succes path
//                if let responseData = value as? [String:Any]{
//                    if let successCode = responseData["success"] as? Int{
//                        if successCode == 498{
//                            let error = [ApiParams.error:AlertsMessage.someThingWentWorng ]
//                            failureHandler?(error)
//
//                        }else{
//                            completionHandler!(value as! [String : Any] )
//                        }
//                    }
//                }
//            case .failure(let error):
//                //                SKActivityIndicator.dismiss()
//                if error._code == NSURLErrorTimedOut {
//                    FTIndicator.showToastMessage("Request timeout!")
//                    print("ERRROR:  Request timeout!")
//                }
//                if error._code == NSURLErrorNetworkConnectionLost {
//                    print("ERRROR:  Connection Lost!")
//                    FTIndicator.showToastMessage("Connection Lost!")
//                }
//                if error._code == NSURLErrorNotConnectedToInternet {
//                    print("ERRROR:  Internet not avialable")
//                    FTIndicator.showToastMessage("Internet not avialable")
//                }
//                if error._code == NSURLErrorCannotConnectToHost {
//                    print("ERRROR:  Could not connect to the server")
//                    FTIndicator.showToastMessage("Could not connect to the server")
//                }
//            }
//        }
//
//
//
//
//
//
//
//
//
//
//
////        response{ response in//
////            print(response.result)
////            switch (response.result) {
////            case .success: // succes path
////                guard let data = response.data else { return }
////                do {
////                    let decoder = JSONDecoder()
////                    let data = try decoder.decode(Base.self, from: data)
////                    if data.msg!.contains("Authorization Failed") || data.msg!.contains("Access key not found"){
////                        self.authFailed(msg: data.msg ?? "")
////                        return
////                    }
////                    closure(data,"")
////                } catch let error {
////                    SKActivityIndicator.dismiss()
////                    //    self.alertPopup(title: "Oops!", message: "Server Error! Please try again later.", image: self.Gif)
////                    FTIndicator.showToastMessage("Server Error! Please try again later.")
////                    print(error)
////                    let errorCode = response.response?.statusCode
////                    print(errorCode!)
////                    closure(nil,"0")
////                }
////            case .failure(let error):
//////                SKActivityIndicator.dismiss()
////                if error._code == NSURLErrorTimedOut {
////                    FTIndicator.showToastMessage("Request timeout!")
////                    print("ERRROR:  Request timeout!")
////                }
////                if error._code == NSURLErrorNetworkConnectionLost {
////                    print("ERRROR:  Connection Lost!")
////                    FTIndicator.showToastMessage("Connection Lost!")
////                }
////                if error._code == NSURLErrorNotConnectedToInternet {
////                    print("ERRROR:  Internet not avialable")
////                    FTIndicator.showToastMessage("Internet not avialable")
////                }
////                if error._code == NSURLErrorCannotConnectToHost {
////                    print("ERRROR:  Could not connect to the server")
////                    FTIndicator.showToastMessage("Could not connect to the server")
////                }
////            }
////        }
//    }


    
    
//    static func refreshToken(completion: @escaping ((Bool) -> Void)){
//
//        APIClient.postAuth(url: .refreshToken, parameters: [:],method: .get,refreshToken: true){ (response) in
//            print(response)
//            if isSuccess(json: response) {
//                //                if let access_token = response[ApiParams.access_token] as? String{
//                //                    UserDefaults.standard.setValue(access_token, forKey: UserDefaultKey.kUserToken)
//                //                }
//                //                if let refresh_token = response[ApiParams.refresh_token] as? String{
//                //                    UserDefaults.standard.setValue(refresh_token, forKey: UserDefaultKey.kUserRefreshToken)
//                //                }
//                completion(true)
//            }else{
//                completion(false)
//            }
//        } failureHandler: { (error) in
//            print(error)
//            completion(false)
//        }
//
//    }
    
}

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}

struct JSONArrayEncoding: ParameterEncoding {
    private let array: [Parameters]
    
    init(array: [Parameters]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}
class NetworkState {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
