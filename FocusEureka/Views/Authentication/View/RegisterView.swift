//
//  RegisterView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct RegisterView: View {
    @State var username: String = "";
    @State var password: String = "";
    @State var fristname: String = "";
    @State var middelname: String = "";
    @State var lastname: String = "";
    @State var comfirePassword: String = "";
    
    // for pops back 1 previous view
    // 2 follow Environment var can work
    // @Environment(\.dismiss) var dismiss;
    @Environment(\.presentationMode) var presentationMode;
    
    @EnvironmentObject var loginViewModel: LoginViewModel;
    
    var body: some View {
        VStack {
            Image(systemName: "camera")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding(.vertical, 20)
            
            VStack(spacing: 20) {
                InputComponentView(
                    inputText: self.$username,
                    title: "Username",
                    placeHolder: "Enter your username",
                    isSecureField: false
                )
                .autocapitalization(.none)
                
                InputComponentView(
                    inputText: self.$password,
                    title: "Password",
                    placeHolder: "Enter your password",
                    isSecureField: true
                )
                
                InputComponentView(
                    inputText: self.$fristname,
                    title: "FristName",
                    placeHolder: "Enter your FristName",
                    isSecureField: false
                )
                
                InputComponentView(
                    inputText: self.$middelname,
                    title: "MiddleName",
                    placeHolder: "Enter your MiddleName",
                    isSecureField: false
                )
                
                InputComponentView(
                    inputText: self.$lastname,
                    title: "LastName",
                    placeHolder: "Enter your LastName",
                    isSecureField: false
                )

                
                ZStack(alignment: .trailing) {
                    InputComponentView(
                        inputText: self.$comfirePassword,
                        title: "Comfire Password",
                        placeHolder: "Comfire your Password",
                        isSecureField: true
                    )
                    if (!password.isEmpty && !comfirePassword.isEmpty) {
                        if (password == comfirePassword) {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                    }
                }

            }
            .padding(.horizontal)
            .padding(.top)
            
            // sign up button
            Button(action: {
                // print("signup button ...")
                Task {
                    loginViewModel.createUser(username:self.username, password:self.password, fname:self.fristname, mname:self.middelname , lname:self.lastname)
                }
            }, label: {
                HStack(spacing: 10) {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                    Image(systemName: "arrow.right")
                }
            })
            .foregroundColor(.white)
            // UIScreen.main.bounds -> get current view rectangle size
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            .background(.blue)
            .disabled(!formIsVaild)
            .opacity(formIsVaild ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button(action: {
                // action for pops back 1 previous view
                // dismiss()
                presentationMode.wrappedValue.dismiss();
            }, label: {
                HStack(spacing: 3) {
                    Text("already have an account ")
                    Text("SIGN IN")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            })
        }
    }
}

// MARK: - LoginfromProtocol
extension RegisterView: LoginfromProtocol {
    var formIsVaild: Bool {
        get {
            return !username.isEmpty && !password.isEmpty && password.count > 5 && comfirePassword == password
        }
    }
}

#Preview {
    RegisterView()
}


