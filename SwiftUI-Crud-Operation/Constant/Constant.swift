//
//  Constants.swift
//  SwiftUI-Crud-Operation
//
//  Created by PIYUSH GHOGHARI on 13/02/20.
//  Copyright © 2020 iTouchSoulation. All rights reserved.
//

import UIKit

class Constant: NSObject {
    //App details
    struct AppDetails {
        static let kAppName = "SwiftUI-Crud-Operation"
    }
    
    struct ScreenSize {
        static let Height = UIScreen.main.bounds.height
        static let Width  = UIScreen.main.bounds.width
    }
    
    //Device Type
    struct Devices {
        static let iPhone4          = (ScreenSize.Height == 480)
        static let iPhone5          = (ScreenSize.Height == 568)
        static let iPhone6          = (ScreenSize.Height == 667)
        static let iPhone6Plus      = (ScreenSize.Height == 736)
        static let iPhone_X         = (ScreenSize.Height == 812)
        static let iPhone_XS_MAX    = (ScreenSize.Height == 896)
    }
    
    struct KeyMessage {
        static let kSomethingWrong                  = "Something went wrong, try again"
    }    
    //Service List
    struct Service {
        //BASE URL
        static let BaseUrl                      = "http://localhost:3000/"
        // Login Screen
        static let kUserData                    = BaseUrl + "User"
    }
}
