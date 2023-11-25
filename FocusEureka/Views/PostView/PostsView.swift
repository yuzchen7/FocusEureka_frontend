//
//  PostsView.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI

enum postState{
    case general, events, spots
}

struct PostsView: View {
    @StateObject var postVM = PostsViewModel()
    var viewState = postState.general
    var body: some View {
        NavigationStack{
            switch viewState {
            case .general:
                PostComponent(postLColumn: postVM.LColumns, postRColumn: postVM.RColumns)
                    .environmentObject(postVM)
            case .events:
                PostComponent(postLColumn: postVM.LColumns, postRColumn: postVM.RColumns)
                    .environmentObject(postVM)
            case .spots:
                PostComponent(postLColumn: postVM.LColumns, postRColumn: postVM.RColumns)
                    .environmentObject(postVM)
            }
//            PostComponent(postLColumn: postVM.LColumns, postRColumn: postVM.RColumns)
//                .environmentObject(postVM)
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

