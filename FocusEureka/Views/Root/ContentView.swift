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
                        Text("Expore")
                    }
                CreatePost()
                    .tabItem {
                        Image(systemName: "plus.square.fill")
                        Text("Post")
                    }
                if (self.loginViewModel.sessionUser != nil) {
                    AccountView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("User")
                        }
                } else {
                    LoginView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("User")
                        }
                }
            }
            .toolbarBackground(.pink, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
