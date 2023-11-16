//
//  ContentView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/14/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel;
    
    var body: some View {
        Group {
            if (self.loginViewModel.sessionUser != nil) {
                AccountView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
