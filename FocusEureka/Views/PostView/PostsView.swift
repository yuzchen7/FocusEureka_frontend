//
//  PostsView.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI

struct PostsView: View {
    @StateObject var postVM = PostsViewModel()
    private var homeGridItems: [GridItem] = [
            .init(.flexible())
        ]
    var body: some View {
        NavigationStack{
            //display the title of each posts
            ScrollView(showsIndicators: false){
                HStack(alignment: .top){
                    LazyVGrid(columns: homeGridItems) {
                        ForEach(postVM.LColumns){ post in
                            NavigationLink(
                                value: post
                            ){
                                CardView(imageURL: post.image_set.urls[0], title: post.title, Likes: post.post_likes?.count ?? 0, posterName: post.owner.username,
                                         postId:post.id,
                                         userId: 1
                                )
                            }
                        }
                    }
                    LazyVGrid(columns: homeGridItems) {
                        ForEach(postVM.RColumns){ post in
                            NavigationLink(
                                value: post
                            ){
                                CardView(imageURL: post.image_set.urls[0], title: post.title, Likes: post.post_likes?.count ?? 0, posterName: post.owner.username,
                                         postId:post.id,
                                         userId: 1
                                )
                            }
                        }
                    }
                }
            }
            .background(.gray.opacity(0.2))
            .navigationTitle("Interesting Spot")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Posts.self, destination: { detailPost in
                PostDetailView(detailedPost: detailPost)
            })
            .onAppear(){
                postVM.LColumns.removeAll()
                postVM.RColumns.removeAll()
                postVM.loadData()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PostsView()
}

