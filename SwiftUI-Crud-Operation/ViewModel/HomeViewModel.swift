
//
//  HomeViewModel.swift
//  SwiftUI-Crud-Operation
//
//  Created by PIYUSH GHOGHARI on 13/02/20.
//  Copyright © 2020 iTouchSoulation. All rights reserved.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var userDataArray = [UserModel]()
    
    func getUserDataListViewModel() {
        let objServiceCall = ServiceCall()
        objServiceCall.getUserListDataAPI(successBlock: { (tempUserDataArray) in
            if tempUserDataArray.count > 0 {
                self.userDataArray = tempUserDataArray
            }
        }) { (errorMessage: String) in
            print("errorMessage: -> \(errorMessage)")
        }
    }
    
}
