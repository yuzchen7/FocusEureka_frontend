//
//  CommentsComponent.swift
//  FocusEureka
//
//  Created by kai on 11/19/23.
//

import SwiftUI

struct CommentsComponent: View {
    var commentsToPost:[Comments]
    @Binding var commentID: Int
    @Binding var reply: String
    @Binding var isReplying: Bool
    @Binding var replys_to:String
    @Binding var isCommenting: Bool
    @State var isExpanding:Bool = false
    var body: some View {
        VStack{
            Divider()
            HStack() {
                Text("\(commentsToPost.count) Comments")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.leading)
            Button(action: {
                isCommenting = true
            }, label: {
                Rectangle()
                    .frame(width: 200,height: 35,alignment: .leading)
                    .cornerRadius(30)
                    .overlay {
                        Text("Let everyone hear your voice")
                            .foregroundStyle(Color.black.opacity(0.3))
                    }
                    .foregroundColor(.gray.opacity(0.1))
            })
            .padding(.bottom)
            VStack{
                ForEach(commentsToPost, id: \.self){comment in
                    HStack(alignment: .top,spacing: 10){
                        //main comment
                        HStack{
                            Image(systemName: "person.crop.circle")
                        }
                        VStack(alignment: .leading){
                            Text("\(comment.user?.username ?? "")")
                                .font(.caption)
                            Text(": \(comment.contents)")
                            HStack(alignment: .center, spacing: 118){
                                Button {
                                    isReplying = true
                                    commentID = comment.id
                                    replys_to = ""
                                } label: {
                                    Image(systemName: "text.bubble")
                                }
                                //expand comment
                                if(comment.reply_comment?.count != 0){
                                    Button {
                                        isExpanding = !isExpanding
                                    } label: {
                                        Image(systemName: "ellipsis")
                                    }
                                }
                            }
                            //replies under commment
                            if(isExpanding){
                                ForEach(comment.reply_comment ?? [], id: \.self){ replys in
                                    HStack(spacing: 10){
                                        VStack{
                                            Image(systemName: "person.crop.circle")
                                        }
                                        VStack(alignment: .leading){
                                            if(replys.replied_to != nil){
                                                Text("\(replys.user?.username ?? "") reply to \(replys.replied_to ?? "")")
                                                    .font(.caption)
                                                    .lineLimit(1)
                                            }else{
                                                Text("\(replys.user?.username ?? "")")
                                                    .font(.caption)
                                            }
                                            Text(" \(replys.contents)")
                                                .font(.system(size: 16))
                                            Button {
                                                isReplying = true
                                                commentID = comment.id
                                                replys_to = replys.user?.username ?? ""
                                            } label: {
                                                Image(systemName: "text.bubble")
                                            }
                                        }
                                        .padding(.top)
                                    }
                                }
                            }
                            Divider()
                        }
                        Spacer()
                    }
                    .padding(.leading)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    CommentsComponent(
        commentsToPost: [
            Comments(
                id: 1,
                onwer_id: 1,
                user: FocusEureka.User_Comments(id: 1, username: "Yuzhuang7789@gmail.com"),
                post_id: 1,
                contents: "Very excited about the event...",
                createdAt: "2023-11-19T21:33:50.298Z",
                updatedAt: "2023-11-19T21:33:50.298Z",
                reply_comment_id: nil,
                replied_to: nil,
                reply_comment: Optional([
                    FocusEureka.Comments(
                        id: 2,
                        onwer_id: 2,
                        user: FocusEureka.User_Comments(id: 2, username:    "Kaifeng99890@gmail.com"),
                        post_id: 1,
                        contents: "cant wait to see the event...",
                        createdAt: "2023-11-19T21:33:50.298Z",
                        updatedAt: "2023-11-19T21:33:50.298Z",
                        reply_comment_id: Optional(1),
                        replied_to: nil,
                        reply_comment: nil),
                    FocusEureka.Comments(
                        id: 5,
                        onwer_id: 6,
                        user: FocusEureka.User_Comments(id: 6, username: "Jenna9223@gmail.com"),
                        post_id: 1, contents: "这个是个测试",
                        createdAt: "2023-11-30T18:55:58.291Z",
                        updatedAt: "2023-11-30T18:55:58.291Z",
                        reply_comment_id: Optional(1),
                        replied_to: Optional("Kaifeng99890@gmail.com"),
                        reply_comment: nil)
                ])
            ),
            Comments(
                id: 4,
                onwer_id: 3,
                user: FocusEureka.User_Comments(id: 3, username: "AdienLogan@gmail.com"),
                post_id: 1,
                contents: "testing testing",
                createdAt: "2023-11-19T21:33:50.298Z",
                updatedAt: "2023-11-19T21:33:50.298Z",
                reply_comment_id: nil,
                replied_to: nil,
                reply_comment: Optional([
                ]))
        ],
        commentID: .constant(0),
        reply: .constant(""),
        isReplying: .constant(false),
        replys_to: .constant(""),
        isCommenting: .constant(false)
    )
}
