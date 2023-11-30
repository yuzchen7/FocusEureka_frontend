//
//  PostDetailView.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI

struct PostDetailView: View {
    var detailedPost:Posts
    enum userInput{
        case commentInput, userReply
    }
    @StateObject var postVM = PostsViewModel()
//    @EnvironmentObject var postVM: PostsViewModel
    @State var isGrouping: Bool = false
    @State var comment: String = ""
    @State var isCommenting: Bool = false
    @State var commentID:Int = 0
    @State var reply: String = ""
    @State var isReplying: Bool = false
    @FocusState var focusTextField: userInput?
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                //Images tabview
                TabView{
                    ForEach(postVM.singlePost?.image_set.urls ?? [], id: \.self){picture in
                        AsyncImage(url: URL(string:picture)) { detailedImage in
                            detailedImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height:UIScreen.main.bounds.height/2)
                .background(Color.gray.opacity(0.1))
                //Title
                HStack{
                    VStack(alignment: .leading){
                        Text("\(postVM.singlePost?.title ?? "")")
                            .font(.system(size:28, design: .rounded))
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack{
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                    }
                    .frame(width: 40)
                }
                .padding(.horizontal)
                //Contents
                VStack{
                    Text(postVM.singlePost?.contents ?? "")
                        .font(.system(size: 20))
                }
                .padding(.horizontal)
                //address
                HStack{
                    Image(systemName: "location")
                    VStack(alignment: .leading){
                        Text("\(postVM.singlePost?.address ?? "")")
                        HStack{
                            Text("\(postVM.singlePost?.city ?? "")")
                            Text("\(postVM.singlePost?.state ?? "")")
                            Text("\(postVM.singlePost?.zipcode ?? "")")
                        }
                    }
                    Spacer()
                }
                .padding(.top)
                .padding(.leading)
                Divider()
                //date & times
                HStack{
                    Image(systemName: "hourglass")
                    VStack{
                        if(postVM.singlePost?.event == true){
                            Text("Event begins at: ")
                            if let DateBegin = postVM.singlePost?.start_date {
                                Text("\(DateBegin)")
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
                    VStack{
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
                    .padding(.leading)
                    Spacer()
                }
                .padding(.leading)
                Button(action: {
                    isCommenting = true
                }, label: {
                    Rectangle()
                        .frame(width: 200,height: 40,alignment: .leading)
                        .cornerRadius(30)
                        .overlay {
                            Text("Let us hear your voice")
                                .foregroundStyle(Color.black.opacity(0.3))
                        }
                        .foregroundColor(.gray.opacity(0.1))
                })
                CommentsComponent(commentsToPost: postVM.singlePost?.comments ?? [], commentID: $commentID, reply: $reply, isReplying: $isReplying)
            }
//            HStack{
//                HStack{
//                    Button(
//                        action: {
//                            Task{
//                                try await postVM.addLikes(postID: postVM.singlePost?.id ?? 6, userID: 1)
//                            }
//                        },
//                        label: {
//                            Image(systemName: "heart.circle")
//                            Text("\(postVM.singlePost?.post_likes?.count ?? 0)")
//                                .foregroundStyle(Color.white)
//                        })
//                }
//                HStack{
//                    Button {
//                        isGrouping = true
//                    } label: {
//                        Text("lets group")
//                            .foregroundStyle(Color.white)
//                    }
//                }
//            }
//            .padding()
//            .background(Color.pink.opacity(0.7))
            if(isCommenting){
                TextField("",text: $comment)
                    .focused($focusTextField, equals: .commentInput)
                    .background(.gray.opacity(0.1))
                    .frame(width: UIScreen.main.bounds.width, height: 40)
                    .submitLabel(.done)
                    .onAppear{
                        focusTextField = .commentInput
                    }
                    .onSubmit {
                        Task{
                            if(!comment.isEmpty && !comment.trimmingCharacters(in: .whitespaces).isEmpty){
                                try await postVM.userInputComment(userID: 1, postID: postVM.singlePost?.id ?? 1, userInput: comment)
                            }
                            isCommenting = false
                            comment = ""
                        }
                    }
            }
            if(isReplying){
                TextField("",text: $reply)
                    .focused($focusTextField, equals: .userReply)
                    .background(.gray.opacity(0.1))
                    .frame(width: UIScreen.main.bounds.width, height: 40)
                    .submitLabel(.done)
                    .onAppear{
                        focusTextField = .userReply
                    }
                    .onSubmit {
                        Task{
                            if(!reply.isEmpty && !reply.trimmingCharacters(in: .whitespaces).isEmpty){
                                try await postVM.userInputReply(userID: 1, postID: postVM.singlePost?.id ?? 1, userInput: reply, replyID: commentID)
                            }
                            isReplying = false
                            reply = ""
                        }
                    }
            }
        }
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
