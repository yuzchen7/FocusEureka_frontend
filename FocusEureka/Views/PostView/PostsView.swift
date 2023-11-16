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
            //display the title of each posts
            ScrollView{
                ForEach(postVM.posts){ post in
                    NavigationLink(
                        value: post
                    ){
                        VStack{
                            CardView(imageURL: post.image_set.urls[0], title: post.title, Likes: post.post_likes?.count ?? 0, posterName: post.owner.username)
                        }
//                        VStack{
//                            CardView(imageURL: post.image_set.urls[0], title: post.title, Likes: post.post_likes?.count ?? 0, posterName: post.owner.username)
//                        }
                    }
                }
            }
            .background(.gray.opacity(0.2))
            .navigationTitle("Interesting Spot")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Posts.self, destination: { detailPost in
                PostDetailView(detailedPost: detailPost)
            })
            .refreshable{
                postVM.handleRefreash()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PostsView()
}

