//
//  ProfileView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel;
    var body: some View {
        if let user = loginViewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.white))
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(user.fullName)
                                .font(.subheadline )
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.username)
                                .font(.footnote)
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                }
                
                Section("General") {
                    HStack {
                        SettingRowView(image: "gear", title: "Version", tinColor: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(Color(.gray))
                    }
                }
                
                Section("Account") {
                    Button(action: {
                        self.loginViewModel.signOut();
                    }, label: {
                        SettingRowView(image: "arrow.left.circle.fill", title: "Sign Out", tinColor: Color(.systemRed))
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        SettingRowView(image: "xmark.circle.fill", title: "Delete Account", tinColor: Color(.systemRed))
                    })
                }
            }
        }

    }
}

#Preview {
    ProfileView()
}

