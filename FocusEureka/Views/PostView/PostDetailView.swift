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
//    @EnvironmentObject var postVM: PostsViewModel
    @State var isGrouping: Bool = false
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                TabView{
                    ForEach(postVM.singlePost?.image_set.urls ?? [], id: \.self){picture in
                        AsyncImage(url: URL(string:picture)) { detailedImage in
                            detailedImage
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height:UIScreen.main.bounds.height/2)
                .background(Color.gray.opacity(0.1))
                HStack{
                    VStack(alignment: .leading){
                        Text("\(postVM.singlePost?.title ?? "")")
                            .font(.system(size:28, design: .rounded))
                            .fontWeight(.bold)
                    }
                    .background(Color.gray.opacity(0.1))
                    Spacer()
                    VStack{
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 40)
                }
                .padding(.horizontal)
                VStack{
                    Text(postVM.singlePost?.contents ?? "")
                        .font(.system(size: 20))
                }
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))
                VStack{
                    HStack{
                        Image(systemName: "location")
                        Text("\(postVM.singlePost?.address ?? "")")
                    }
                    HStack{
                        Text("\(postVM.singlePost?.city ?? "")")
                        Text("\(postVM.singlePost?.state ?? "")")
                        Text("\(postVM.singlePost?.zipcode ?? "")")
                    }
                }
                if(postVM.singlePost?.event == true){
                    HStack{
                        if let DateBegin = postVM.singlePost?.start_date {
                            Text("Event begins at: \(DateBegin)")
                        } else {
                            Text("???")
                        }
                        if let DateEnd = postVM.singlePost?.end_date {
                            Text("- \(DateEnd)")
                        } else {
                            Text("???")
                        }

                    }
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
                Spacer()
                ForEach(postVM.singlePost?.comments ?? [], id: \.self){comment in
                    HStack{
                        Text("\(comment.contents)")
                    }
                }
                HStack{
                    HStack{
                        Button(
                            action: {
                                Task{
                                    try await postVM.addLikes(postID: postVM.singlePost?.id ?? 6, userID: 1)
                                }
                            },
                            label: {
                                Image(systemName: "heart.circle")
                                Text("\(postVM.singlePost?.post_likes?.count ?? 0)")
                                    .foregroundStyle(Color.white)
                            })
                    }
                    HStack{
                        Button {
                            isGrouping = true
                        } label: {
                            Text("lets group")
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                .padding()
                .background(Color.pink.opacity(0.7))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .task{
            Task{
                try await postVM.fetchSinglePost(postID: detailedPost.id)
            }
        }
        .sheet(isPresented: $isGrouping, content: {
                
        })
    }
}

#Preview {
    PostDetailView(
        detailedPost:
            MockData.dummyPost
    )
}
