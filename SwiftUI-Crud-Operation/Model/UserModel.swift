//
//  UserModel.swift
//  SwiftUI-Crud-Operation
//
//  Created by PIYUSH GHOGHARI on 13/02/20.
//  Copyright © 2020 iTouchSoulation. All rights reserved.
//

import Foundation
import UIKit

class UserModel: NSObject, Identifiable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var acceptsTermsConditions: Bool?
    var dateOfBirth: String?
    var notification: String?
    
    override init() {
        super.init()
    }
    
    init(dicUserModel: [String: Any]) {
        id = dicUserModel["id"] as? Int
        firstName = dicUserModel["firstname"] as? String
        lastName = dicUserModel["lastname"] as? String
        acceptsTermsConditions = dicUserModel["TermsConditions"] as? Bool
        dateOfBirth = dicUserModel["dateOfBirth"] as? String
        notification = dicUserModel["notification"] as? String
    }
}
