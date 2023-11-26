//
//  PostsView.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI

//enum postState{
//    case general, events, spots
//}

struct PostsView: View {
    @StateObject var postVM = PostsViewModel()
    var body: some View {
        NavigationStack{
            Button(action: {
                postVM.switchPostType()
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            switch postVM.viewState {
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

