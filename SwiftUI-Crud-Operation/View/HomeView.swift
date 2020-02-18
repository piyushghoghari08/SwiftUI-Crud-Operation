//
//  HomeView.swift
//  SwiftUI-Crud-Operation
//
//  Created by PIYUSH GHOGHARI on 13/02/20.
//  Copyright © 2020 iTouchSoulation. All rights reserved.
//

import SwiftUI
var tempNotificationCenter = NotificationCenter.default

struct HomeView: View {
    
    @State var isPresentingAddModal = false
    @ObservedObject var userData = HomeViewModel()
    @State var objSelectedUserData = UserModel()
    @State var buttonClick = "add"
    
//    init() {
//        self.userData.getUserDataListViewModel()
//    }
    
    var body: some View {
        NavigationView {
            List(userData.userDataArray){ objUserData in
                HStack {
                    VStack (alignment: .leading) {
                        Text("\(objUserData.firstName ?? "") \(objUserData.lastName ?? "")")
                            .fontWeight(.bold)
                        if objUserData.acceptsTermsConditions == true {
                            Text("online")
                                .fontWeight(.light)
                        } else {
                            Text("Offline")
                                .fontWeight(.light)
                        }
                    }
                    Spacer()
                    // Edit Button
                    Button(action: {
                        self.objSelectedUserData = objUserData
                        self.buttonClick = "edit"
                        self.isPresentingAddModal.toggle()
                    }, label: {
                        Text("Edit")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.all, 12)
                            .background(Color.green)
                            .cornerRadius(3)
                    })
                    // End
                    // Delete Button
                    Button(action: {}, label: {
                        Text("Delete")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.all, 12)
                            .background(Color.red)
                            .cornerRadius(3)
                    }).onTapGesture {
                        if self.buttonClick != "edit" || self.buttonClick != "add" {
                                                   let objDeleteData = ServiceCall()
                                                   objDeleteData.deleteUserDataAPI(id: objUserData.id ?? 0,
                                                                                   successBlock: { (success) in
                                                                                       self.userData.getUserDataListViewModel()
                                                   }) { (errorMessage: String) in
                                                       print("errorMessage: -> \(errorMessage)")
                                                   }
                                                   
                                               }
                    }
                    // End
                    
                }.padding(.vertical, 8)
            }.navigationBarTitle("User List")
                .navigationBarItems(leading: Button(action: {
                    self.userData.getUserDataListViewModel()
                }, label: {
                    Text("Refresh")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.green)
                        .cornerRadius(4)
                }), trailing: Button(action: {
                    self.objSelectedUserData = UserModel()
                    self.buttonClick = "add"
                    self.isPresentingAddModal.toggle()
                }, label: {
                    Text("+Add")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.green)
                        .cornerRadius(4)
                    
                }))
                .sheet(isPresented: $isPresentingAddModal, content: {
                    AddUserDataView(isPresented: self.$isPresentingAddModal,
                                    data: self.objSelectedUserData,
                                    buttonClickStatus: self.buttonClick)
                })
        }.onAppear() {
            self.userData.getUserDataListViewModel()
            tempNotificationCenter.addObserver(forName: Notification.Name("updateUserData"), object: nil, queue: nil) { (_) in
                self.userData.getUserDataListViewModel()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
