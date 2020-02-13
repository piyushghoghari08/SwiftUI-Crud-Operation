//
//  ServiceCall.swift
//  SwiftUI-Crud-Operation
//
//  Created by PIYUSH GHOGHARI on 13/02/20.
//  Copyright © 2020 iTouchSoulation. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ServiceCall: NSObject {
    // MARK: - GetUser API Call
    func getUserListDataAPI(successBlock:@escaping (_ objUserModelData: [UserModel]) -> (),
                            errorBlock:@escaping (_ strMsg: String) -> ()) {
        ServiceManager.sharedInstance.callWebService(withURL: URL(string: Constant.Service.kUserData)!,
                                                     withMethod: .get,
                                                     withParameter: nil,
                                                     withShowLoader: false,
                                                     successBlock: { (dictResponse: [[String: AnyObject]]) in
                                                        print("=======================================================")
                                                        print("\(Constant.Service.kUserData) Response : \(dictResponse)")
                                                        var tempUserModel = [UserModel]()
                                                        for objUserModel in dictResponse {
                                                            let tempObjUserModel = UserModel(dicUserModel: objUserModel)
                                                            tempUserModel.append(tempObjUserModel)
                                                        }
                                                        successBlock(tempUserModel)
        }) { (strMSG : String) in
            print("Error message : \(strMSG)")
            errorBlock(strMSG)
        }
    }
    // MARK: - Add User Data API
    func addUserDataAPI(firstName: String,
                        lastName: String,
                        acceptsTermsConditions: Bool,
                        dateOfBirth: String,
                        notificationType: String,
                        successBlock:@escaping (_ success: String) -> (),
                        errorBlock:@escaping (_ strMsg: String) -> ()) {
        let parameter = ["firstname": firstName,
                         "lastname": lastName,
                         "TermsConditions": acceptsTermsConditions,
                         "dateOfBirth": dateOfBirth,
                         "notification": notificationType] as [String : Any]
        ServiceManager.sharedInstance.addCallWebService(withURL: URL(string: Constant.Service.kUserData)!,
                                                        withMethod: .post,
                                                        withParameter: parameter,
                                                        withShowLoader: true,
                                                        successBlock: { (dictResponse: [String: AnyObject]) in
                                                            print("=======================================================")
                                                            print("\(Constant.Service.kUserData) Response : \(dictResponse)")
                                                            successBlock("Add user add successfull...!")
        }) { (strMSG : String) in
            print("Error message : \(strMSG)")
            errorBlock(strMSG)
        }
    }
    
    // MARK: - Update User API Call
    func updateUserDataAPI(firstName: String,
                           lastName: String,
                           acceptsTermsConditions: Bool,
                           dateOfBirth: String,
                           notificationType: String,
                           id: Int,
                           successBlock:@escaping (_ success: String) -> (),
                           errorBlock:@escaping (_ strMsg: String) -> ()) {
        let parameter = ["firstname": firstName,
                         "lastname": lastName,
                         "TermsConditions": acceptsTermsConditions,
                         "dateOfBirth": dateOfBirth,
                         "notification": notificationType] as [String : Any]
        let strServiceURL = Constant.Service.kUserData + "/\(id)"
        ServiceManager.sharedInstance.addCallWebService(withURL: URL(string: strServiceURL)!,
                                                        withMethod: .put,
                                                        withParameter: parameter,
                                                        withShowLoader: true,
                                                        successBlock: { (dictResponse: [String: AnyObject]) in
                                                            print("=======================================================")
                                                            print("\(Constant.Service.kUserData) Response : \(dictResponse)")
                                                            successBlock("User data update successfull...!")
        }) { (strMSG : String) in
            print("Error message : \(strMSG)")
            errorBlock(strMSG)
        }
    }
    
    // MARK: - Delete User Data API Call
    func deleteUserDataAPI(id: Int,
                           successBlock:@escaping (_ success: String) -> (),
                           errorBlock:@escaping (_ strMsg: String) -> ()) {
        let strServiceURL = Constant.Service.kUserData + "/\(id)"
        ServiceManager.sharedInstance.addCallWebService(withURL: URL(string: strServiceURL)!,
                                                        withMethod: .delete,
                                                        withParameter: nil,
                                                        withShowLoader: true,
                                                        successBlock: { (dictResponse: [String: AnyObject]) in
                                                            print("=======================================================")
                                                            print("\(Constant.Service.kUserData) Response : \(dictResponse)")
                                                            successBlock("User data delete successfull...!")
        }) { (strMSG : String) in
            print("Error message : \(strMSG)")
            errorBlock(strMSG)
        }
    }
}
