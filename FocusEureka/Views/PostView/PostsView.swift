//
//  PostsView.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI

struct PostsView: View {
    @StateObject var postVM = PostsViewModel()
    var body: some View {
        NavigationStack{
            Text("")
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    Button(action: {
                        postVM.switchPostType()
                    }, label: {
                        switch postVM.viewState {
                        case .general:
                            Image("generalPost")
                        case .events:
                            Image("events")
                        case .spots:
                            Image("spot")
                        }
                    })
                }
            }
        PostComponent(postLColumn: postVM.LColumns, postRColumn: postVM.RColumns)
                .environmentObject(postVM)
        }
        .onAppear(){
            postVM.loadPostData()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PostsView()
}

