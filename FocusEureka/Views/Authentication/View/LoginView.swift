//
//  LoginView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = "";
    @State var password: String = "";
    @EnvironmentObject var loginViewModel: LoginViewModel;
    
    var body: some View {
        NavigationStack {
            VStack {
                // background
                // Image
                Image(systemName: "camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .padding(.vertical, 20)
                
                // username and password form
                VStack(spacing: 20) {
                    InputComponentView(
                        inputText: self.$username,
                        title: "Username",
                        placeHolder: "Enter your username",
                        isSecureField: false
                    )
                    .autocapitalization(.none)
                    // disable/pervert system auto change all character to capital
                    
                    InputComponentView(
                        inputText: self.$password,
                        title: "Password",
                        placeHolder: "Enter your password",
                        isSecureField: true
                    )
                }
                .padding(.horizontal)
                .padding(.top)
                
                // sign in button
                Button(action: {
                    // print("login button ... ")
                    // self.loginViewModel.signIn(username:self.username, password:self.password)
                    self.loginViewModel.signIn(username:self.username, password:self.password)
                }, label: {
                    HStack(spacing: 10) {
                        Text("SIGN IN")
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
                
                // sign up button
                // NavigationLink must be in the NavigationStack
                // otherwise it will not work
                NavigationLink(destination: {
                    RegisterView()
                        .navigationBarBackButtonHidden(true)
                        // for hidden the back button on top of the left hand side
                        // default value if false, which means that
                        // it will display the back button
                } , label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account")
                        Text("SIGN UP")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.blue)
                })
            }
        }
    }
}

// MARK: - LoginfromProtocol
extension LoginView: LoginfromProtocol {
    var formIsVaild: Bool {
        get {
            return !username.isEmpty && !password.isEmpty && password.count > 5
        }
    }
}

#Preview {
    LoginView(username: "", password: "")
}

