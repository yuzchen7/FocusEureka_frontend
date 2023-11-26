//
//  PostComponent.swift
//  FocusEureka
//
//  Created by kai on 11/19/23.
//

import SwiftUI

struct PostComponent: View {
    var pinterestView: [GridItem] = [
        .init(.flexible())
    ]
    var postLColumn:[Posts]
    var postRColumn:[Posts]
    @EnvironmentObject var postVM : PostsViewModel
    var body: some View {
        ScrollView(showsIndicators: false){
            HStack(alignment: .top, spacing: 1){
                LazyVGrid(columns: pinterestView) {
                    ForEach(postLColumn){ post in
                        NavigationLink(
                            value: post
                        ){
                            CardComponent(imageURL: post.image_set.urls[0], title: post.title, Likes: post.post_likes?.count ?? 0, posterName: post.owner.username,
                                          postId:post.id,
                                          userId: 1
                            )
                        }
                    }
                }
                LazyVGrid(columns: pinterestView) {
                    ForEach(postRColumn){ post in
                        NavigationLink(
                            value: post
                        ){
                            CardComponent(imageURL: post.image_set.urls[0], title: post.title, Likes: post.post_likes?.count ?? 0, posterName: post.owner.username,
                                          postId:post.id,
                                          userId: 1)
                        }
                    }
                }
            }
        }
        .background(.gray.opacity(0.2))
//        .navigationTitle("Interesting Spot")
//        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Posts.self, destination: { detailPost in
            PostDetailView(detailedPost: detailPost)
        })
    }
}

#Preview {
    PostComponent(postLColumn: [], postRColumn: [])
}
