//
//  PostDetailView.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI

struct PostDetailView: View {
    var detailedPost:Posts
    @StateObject var postVM = PostsViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                TabView{
                    ForEach(postVM.singlePost?.image_set.urls ?? [], id: \.self){picture in
                        AsyncImage(url: URL(string:picture)) { detailedImage in
                            detailedImage
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height:250)
                HStack{
                    Image(systemName: "location")
                    Text("\(postVM.singlePost?.address ?? "")")
                    VStack{
                        Text("\(postVM.singlePost?.city ?? "")")
                        Text("\(postVM.singlePost?.state ?? "")")
                        Text("\(postVM.singlePost?.zipcode ?? "")")
                    }.foregroundColor(.blue)
                }
                HStack{
                    Image(systemName: "hourglass")
                    if let startTime = postVM.singlePost?.start_time {
                        Text("Open at: \(startTime)")
                    } else {
                        Text("Open time unavailable")
                    }
                    
                    if let endTime = postVM.singlePost?.end_time {
                        Text("End at: \(endTime)")
                    } else {
                        Text("End time unavailable")
                    }
                }
                VStack{
                    Text(postVM.singlePost?.contents ?? "")
                }
                Spacer()
                ForEach(postVM.singlePost?.comments ?? [], id: \.self){comment in
                    HStack{
                        Text("\(comment.contents)")
                    }
                }
            }
        }.task{
            Task{
                try await postVM.fetchSinglePost(postID: detailedPost.id)
            }
        }
    }
}

#Preview {
    PostDetailView(
        detailedPost:
            MockData.dummyPost
    )
}
