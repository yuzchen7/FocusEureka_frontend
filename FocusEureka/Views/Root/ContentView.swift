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
        //main view of the app
        TabView{
            Group{
                //view that display all the posts fetched from backend
                PostsView()
                    .tabItem {
                        Image(systemName: "globe.americas")
                            .frame(height:500)
                        Text("Expore")
                    }
                CreatePost()
                    .tabItem {
                        Image(systemName: "plus")
                            .frame(height: 10000)
                        Text("Post")
                    }
                Text("Account")
                    .tabItem{
                        Text("tab2")
                    }
                if (self.loginViewModel.sessionUser != nil) {
                    AccountView()
                        .tabItem {
                            Text("User")
                        }
                } else {
                    LoginView()
                        .tabItem {
                            Text("User")
                        }
                }
            }
            .toolbarBackground(.pink, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
            Group {
                if (self.loginViewModel.sessionUser != nil) {
                    AccountView()
                } else {
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
