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
//    @StateObject var postVM = PostsViewModel()
    @EnvironmentObject var postVM: PostsViewModel
    @State var isGrouping: Bool = false
    @State var comment: String = ""
    @State var isCommenting: Bool = false
    @State var commentID:Int = 0
    @State var reply: String = ""
    @State var isReplying: Bool = false
    @State var replys_to:String = ""
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
//                .frame(height:UIScreen.main.bounds.height/2)
                .frame(height:350)
                .background(Color.gray.opacity(0.1))
                //Title
                HStack{
                    Text("\(postVM.singlePost?.title ?? "")")
                        .font(.system(size:20, design: .monospaced))
                        .fontWeight(.bold)
                    
                    Spacer()
                    VStack{
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                    }
                    .frame(width: 30)
                }
                .padding(.horizontal)
                HStack(spacing:1){
                    HStack{
                        if(postVM.singlePost?.event == true){
                            Text("     ")
                                .font(.footnote)
                            if let DateBegin = postVM.singlePost?.start_date {
                                Text("\(DateBegin)")
                                    .font(.footnote)
                            } else {
                                Text("unknown")
                                    .font(.footnote)
                            }
                            Text("-")
                                .font(.footnote)
                            if let DateEnd = postVM.singlePost?.end_date {
                                Text("\(DateEnd)")
                                    .font(.footnote)
                            } else {
                                Text("unknown")
                                    .font(.footnote)
                            }
                        }
                    }
                    HStack{
                        if let startTime = postVM.singlePost?.start_time {
                            Text("     ")
                                .font(.footnote)
                            Text("\(startTime)")
                                .font(.footnote)
                        } else {
                            Text("Time: unavailable")
                                .font(.footnote)
                        }
                        Text("-")
                            .font(.footnote)
                        if let endTime = postVM.singlePost?.end_time {
                            Text("\(endTime)")
                                .font(.footnote)
                        } else {
                            Text("unavailable")
                                .font(.footnote)
                        }
                    }
                    Spacer()
                }
                //Contents
                HStack(){
                    Text(postVM.singlePost?.contents ?? "")
                        .font(.system(size: 16))
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom)
                //address
                HStack{
                    Image(systemName: "location")
                        .imageScale(.medium)
                    Text("\(postVM.singlePost?.address ?? ""), \(postVM.singlePost?.city ?? ""), \(postVM.singlePost?.state ?? "") \(postVM.singlePost?.zipcode ?? "")")
                        .font(.footnote)
                    Spacer()
                }
                .padding(.top)
                .padding(.leading)
                HStack{
                    Text(" \(postVM.singlePost?.createdAt ?? "")")
                        .font(.caption2)
                        .foregroundStyle(Color.gray.opacity(0.8))
                    Spacer()
                    Button {
                        isGrouping = true
                    } label: {
                        Image(systemName: "person.2.circle")
                            .resizable()
                            .frame(width:20, height: 20)
                    }
                    Button(
                        action: {
                            Task{
                                try await postVM.addLikes(postID: postVM.singlePost?.id ?? 6, userID: 1)
                            }
                        },
                        label: {
                            HStack(spacing:3){
                                Image(systemName: "heart.circle")
                                    .resizable()
                                    .frame(width:20, height: 20)
                                Text("\(postVM.singlePost?.post_likes?.count ?? 0)")
                                    .foregroundStyle(Color.black)
                            }
                        })
//                    Spacer()
                }
                .padding(.horizontal)
                CommentsComponent(commentsToPost: postVM.singlePost?.comments ?? [], commentID: $commentID, reply: $reply, isReplying: $isReplying, replys_to: $replys_to, isCommenting: $isCommenting)
            }
            if(isCommenting){
                TextField("",text: $comment)
                    .disableAutocorrection(true)
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
                    .disableAutocorrection(true)
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
                                if(replys_to.isEmpty){
                                    try await postVM.userInputReply(userID: 1, postID: postVM.singlePost?.id ?? 0, userInput: reply, replyID: commentID)
                                }else{
                                    try await postVM.replyToResponse(userID: 1, postID: postVM.singlePost?.id ?? 0, userInput: reply, replyID: commentID, userReplied: replys_to)
                                }
                            }
                            isReplying = false
                            reply = ""
                            replys_to = ""
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
