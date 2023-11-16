//
//  ContentView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/14/23.
//

import SwiftUI

struct ContentView: View {
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
                    Text("Tab3")
                        .tabItem {
                            Text("tab3")
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
