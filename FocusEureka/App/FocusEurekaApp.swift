//
//  FocusEurekaApp.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/14/23.
//

import SwiftUI

@main
struct FocusEurekaApp: App {
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginViewModel)
                .onAppear {
                    print("AUTO LOGIN:\n\tIts possible to log the error retrieve/save message for the auto signIn feature\n\tignore the follwing message  ╮（￣▽￣）╭ ->")
                    if
                        let savedUsername = loginViewModel.retrieveItem(forkey: "username"),
                        let password = loginViewModel.retrieveItem(forkey: savedUsername)
                    {
                        loginViewModel.signIn(username:savedUsername , password: password)
                    }
                }
        }
    }
}
