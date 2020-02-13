//
//  AddUserDataView.swift
//  SwiftUI-Crud-Operation
//
//  Created by PIYUSH GHOGHARI on 13/02/20.
//  Copyright © 2020 iTouchSoulation. All rights reserved.
//

import SwiftUI

struct AddUserDataView: View {
    @Binding var isPresented: Bool
    var data : UserModel
    var buttonClickStatus = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var notificationType = ""
    @State private var termsAccepted = false
    @State private var id = Int()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State private var selectedDate = Date()
    var notificationMode = ["Lock Screen", "Notification Centre", "Banners"]
    @State private var selectedMode = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Firstname", text: $firstname)
                    TextField("Lastname",
                              text: $lastname)
                    Toggle(isOn: $termsAccepted,
                           label: {
                            Text("Accept terms and conditions")
                    })
                    DatePicker(selection: $selectedDate, in: Date()..., displayedComponents: .date) {
                        Text("Date")
                    }
                    Picker(selection: $selectedMode, label: Text("Notifications")) {
                        ForEach(0..<notificationMode.count) {
                            Text(self.notificationMode[$0])
                        }
                    }
                    Button(action: {
                        if self.buttonClickStatus == "edit" {
                            let objUpdateService = ServiceCall()
                            objUpdateService.updateUserDataAPI(firstName: self.firstname,
                                                               lastName: self.lastname,
                                                               acceptsTermsConditions: self.termsAccepted,
                                                               dateOfBirth: "\(self.selectedDate)",
                                notificationType: self.notificationMode[self.selectedMode],
                                id: self.id,
                                successBlock: { (Success) in
                                    self.isPresented = false
                            }) { (errorMessage: String) in
                                print("errorMessage: -> \(errorMessage)")
                            }
                        } else {
                            let objAddService = ServiceCall()
                            objAddService.addUserDataAPI(firstName: self.firstname,
                                                         lastName: self.lastname,
                                                         acceptsTermsConditions: self.termsAccepted,
                                                         dateOfBirth: "\(self.selectedDate)",
                                notificationType: self.notificationMode[self.selectedMode],
                                successBlock: { (Success) in
                                    self.isPresented = false
                            }) { (errorMessage: String) in
                                print("errorMessage: -> \(errorMessage)")
                            }
                        }
                    }) {
                        Text("Save Data")
                    }
                    
                    
                }
            }.navigationBarTitle("Add Data")
                .navigationBarItems(trailing: Button(action: {
                    self.isPresented = false
                }, label: {
                    Text("close")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.blue)
                        .cornerRadius(4)
                }))
        }.onAppear {
            self.firstname = self.data.firstName ?? ""
            self.lastname = self.data.lastName ?? ""
            self.termsAccepted = self.data.acceptsTermsConditions ?? false
            self.notificationType = self.data.notification ?? ""
            self.id = self.data.id ?? 0
        }
        
    }
}
