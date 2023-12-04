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
                .navigationTitle(postVM.title)
                .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    Button(action: {
                        postVM.switchPostType()
                    }, label: {
                        switch postVM.viewState {
                        case .general:
                            Image(systemName: "camera.fill")
                        case .events:
                            Image(systemName: "party.popper.fill")
                        case .spots:
                            Image(systemName: "mappin")
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

