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
    @State var isGrouping: Bool = false
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false){
                TabView{
                    ForEach(postVM.singlePost?.image_set.urls ?? [], id: \.self){picture in
                        AsyncImage(url: URL(string:picture)) { detailedImage in
                            detailedImage
                                .resizable()
                                .scaledToFit()
//                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height:350)
                HStack{
                    Text("\(postVM.singlePost?.title ?? "")")
                        .font(.system(size:40, design: .rounded))
                        .fontWeight(.bold)
                        .background(.blue)
                }
                VStack{
                    Text(postVM.singlePost?.contents ?? "")
                        .background(.pink)
                        .padding()
                }
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
                Button {
                    isGrouping = true
                } label: {
                    Text("lets group")
                }
                Spacer()
                ForEach(postVM.singlePost?.comments ?? [], id: \.self){comment in
                    HStack{
                        Text("\(comment.contents)")
                    }
                }
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
