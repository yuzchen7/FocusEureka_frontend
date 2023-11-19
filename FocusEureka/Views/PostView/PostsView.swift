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
            PostComponent(postLColumn: postVM.LColumns, postRColumn: postVM.RColumns)
        }
        .onAppear(){
            postVM.LColumns.removeAll()
            postVM.RColumns.removeAll()
            postVM.loadData()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PostsView()
}

