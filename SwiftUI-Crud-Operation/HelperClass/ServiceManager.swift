//
//  ServiceManager.swift
//  DanDin
//
//  Created by PIYUSH  GHOGHARI on 23/01/19.
//  Copyright © 2019 AK_Creation. All rights reserved.
//

import UIKit
import Alamofire

class ServiceManager: NSObject {
    var strToken = String()
    var alamoFireManager = Alamofire.SessionManager.default
    class var sharedInstance : ServiceManager {
        struct Static {
            static let instance : ServiceManager = ServiceManager()
        }
        return Static.instance
    }
    // METHODS
    override init() {
        alamoFireManager.session.configuration.timeoutIntervalForRequest = 10 //seconds
    }
    
    /*=================================================
     * Function Name: callWebService
     * Function Parameter: parameters
     * Function Return Type: dictResponse : [String : AnyObject]
     * Function Purpose: Common Service Calling function.
     ==================================================*/
    func callWebService(withURL url : URL,
                        withMethod methodName: HTTPMethod?,
                        withParameter parameters : Any?,
                        withShowLoader isShowLoader : Bool,
                        successBlock:@escaping (_ dictResponse : [[String : AnyObject]]) -> (),
                        errorBlock:@escaping (_ strMsg: String) -> ()) {
        
        let header = [
            "Content-Type"      : "application/json",
            "Cache-Control"     : "no-cache",
            "Accept"            : "application/json",
            "Accept-Charset"    : "UTF-8",
            "Authorization"     : strToken,
        ]
        print("Service URL : \(url)")
        
        if let dictParam = parameters {
            if JSONSerialization.isValidJSONObject(dictParam) {
                let postData: Data? = try? JSONSerialization.data(withJSONObject: dictParam, options: [])
                let strParam = String(data: postData ?? Data(), encoding: .utf8)
                print("Parameters : \(strParam ?? "No Input Params")")
            }
            else {
                print("Input parameters is not a valid json")
                let error = NSError(domain: "", code: 300, userInfo: ["localizedDescription" : "Input parameters is not a valid json"])
                errorBlock((error.localizedDescription))
            }
        }
        
        Alamofire.request(url, method: methodName!, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: header)
            .responseString(completionHandler: { (strResponse) in
                print("strResponse:-> ",strResponse)
            })
            .responseJSON { response in
                if(response.result.error != nil){
                    errorBlock((response.result.error?.localizedDescription)!)
                }else{
                    if let _ = response.result.value{
                        successBlock(response.result.value as! [[String: AnyObject]])
                    }else{
                        errorBlock(response.result.error as! String)
                    }
                }
        }
    }
    
    /*=================================================
     * Function Name: addCallWebService
     * Function Parameter: parameters
     * Function Return Type: dictResponse : [String : AnyObject]
     * Function Purpose: Common Service Calling function.
     ==================================================*/
    func addCallWebService(withURL url : URL,
                           withMethod methodName: HTTPMethod?,
                           withParameter parameters : Any?,
                           withShowLoader isShowLoader : Bool,
                           successBlock:@escaping (_ dictResponse : [String : AnyObject]) -> (),
                           errorBlock:@escaping (_ strMsg: String) -> ()) {
        
        let header = [
            "Content-Type"      : "application/json",
            "Cache-Control"     : "no-cache",
            "Accept"            : "application/json",
            "Accept-Charset"    : "UTF-8",
            "Authorization"     : strToken,
        ]
        print("Service URL : \(url)")
        
        if let dictParam = parameters {
            if JSONSerialization.isValidJSONObject(dictParam) {
                let postData: Data? = try? JSONSerialization.data(withJSONObject: dictParam, options: [])
                let strParam = String(data: postData ?? Data(), encoding: .utf8)
                print("Parameters : \(strParam ?? "No Input Params")")
            }
            else {
                print("Input parameters is not a valid json")
                let error = NSError(domain: "", code: 300, userInfo: ["localizedDescription" : "Input parameters is not a valid json"])
                errorBlock((error.localizedDescription))
            }
        }
        
        Alamofire.request(url, method: methodName!, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: header)
            .responseString(completionHandler: { (strResponse) in
                print("strResponse:-> ",strResponse)
            })
            .responseJSON { response in
                if(response.result.error != nil){
                    errorBlock((response.result.error?.localizedDescription)!)
                }else{
                    if let _ = response.result.value{
                        successBlock(response.result.value as! [String: AnyObject])
                    }else{
                        errorBlock(response.result.error as! String)
                    }
                }
        }
    }
    /*=================================================
     * Function Name: callWebServiceMediaData
     * Function Parameter: parameters
     * Function Return Type: dictResponse : [String : AnyObject]
     * Function Purpose: Common Service Calling function.
     ==================================================*/
    func callWebServiceMediaData(withURL url : URL,
                                 withMethod methodName: HTTPMethod?,
                                 withParameter parameters : [String : Any]?,
                                 imageData: Data?,
                                 strImageType : String?,
                                 withShowLoader isShowLoader : Bool,
                                 successBlock:@escaping (_ dictResponse : [String : AnyObject]) -> (),
                                 errorBlock:@escaping (_ strMsg: String) -> ()) {
        
        let header = [
            "Content-Type"      : "application/json",
            "Cache-Control"     : "no-cache",
            "Accept"            : "application/json",
            "Accept-Charset"    : "UTF-8",
            "Authorization"     : strToken
        ]
        print("Service URL : \(url)")
        
        if let dictParam = parameters {
            if JSONSerialization.isValidJSONObject(dictParam) {
                let postData: Data? = try? JSONSerialization.data(withJSONObject: dictParam, options: [])
                let strParam = String(data: postData ?? Data(), encoding: .utf8)
                print("Parameters : \(strParam ?? "No Input Params")")
            }
            else {
                print("Input parameters is not a valid json")
                let error = NSError(domain: "", code: 300, userInfo: ["localizedDescription" : "Input parameters is not a valid json"])
                errorBlock((error.localizedDescription))
            }
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters! {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if strImageType == "GIF"{
                if let data = imageData{
                    multipartFormData.append(data, withName: "profile", fileName: "default.gif", mimeType: "image/gif")
                }
            }else{
                if let data = imageData{
                    multipartFormData.append(data, withName: "profile", fileName: "default.png", mimeType: "image/png")
                }
            }
        }, usingThreshold: UInt64.init(), to: url, method: methodName!, headers: header) { (strResponse) in
            switch strResponse{
            case .success(let upload, _, _):
                upload.responseString(completionHandler: { (strResponse) in
                    print("strResponse:-> ",strResponse)
                })
                upload.responseJSON { response in
                    if let _ = response.error{
                        errorBlock(response.result.error as! String)
                    }
                    
                    if let _ = response.result.value{
                        successBlock(response.result.value as! [String : AnyObject])
                    }else{
                        errorBlock(response.result.error as! String)
                    }
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
}
