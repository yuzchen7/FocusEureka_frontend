//
//  UserPostsView.swift
//  FocusEureka
//
//  Created by kai on 12/5/23.
//

import SwiftUI

struct UserPostComponent: View {
    var pinterestView: [GridItem] = [
        .init(.flexible())
    ]
    var postLColumn:[Posts]
    var postRColumn:[Posts]
    @EnvironmentObject var postVM : PostsViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel

    var body: some View {
        ScrollView(showsIndicators: false){
            HStack(alignment: .top, spacing: 1){
                LazyVGrid(columns: pinterestView) {
                    ForEach(postLColumn){ post in
                        NavigationLink(
                            value: post
                        ){
                            UserCardComponent(imageURL: post.image_set.urls[0], title: post.title, Likes: post.post_likes?.count ?? 0, posterName: post.owner.username,
                                          postId:post.id,
                                              userId: loginViewModel.currentUser?.id ?? 0
                            )
                        }
                    }
                }
                LazyVGrid(columns: pinterestView) {
                    ForEach(postRColumn){ post in
                        NavigationLink(
                            value: post
                        ){
                            UserCardComponent(imageURL: post.image_set.urls[0], title: post.title, Likes: post.post_likes?.count ?? 0, posterName: post.owner.username,
                                          postId:post.id,
                                          userId: loginViewModel.currentUser?.id ?? 0)
                        }
                    }
                }
            }
        }
        .background(.gray.opacity(0.2))
        .navigationDestination(for: Posts.self, destination: { detailPost in
            PostDetailView(detailedPost: detailPost)
                .environmentObject(postVM)
        })
    }
}

#Preview {
    UserPostComponent(postLColumn: [], postRColumn: [])
}
