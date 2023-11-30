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
    var body: some View {
        VStack{
            Divider()
            HStack() {
                Text("\(commentsToPost.count) Comments")
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom)
            VStack{
                ForEach(commentsToPost, id: \.self){comment in
                    HStack(alignment: .top,spacing: 10){
                        HStack{
                            Image(systemName: "person.crop.circle")
                        }
                        VStack(alignment: .leading){
                            Text("\(comment.user.username)")
                                .font(.caption)
                            Text(": \(comment.contents)")
                            Button {
                                isReplying = true
                                commentID = comment.id
                            } label: {
                                Image(systemName: "text.bubble")
                            }
                            ForEach(comment.reply_comment ?? [], id: \.self){ replys in
                                HStack(spacing: 10){
                                    VStack{
                                        Image(systemName: "person.crop.circle")
                                    }
                                    VStack(alignment: .leading){
                                        Text("\(replys.user.username)")
                                            .font(.caption)
                                        Text(": \(replys.contents)")
                                    }
                                    .padding(.top)
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
                replyied_to: nil,
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
                        replyied_to: nil,
                        reply_comment: nil),
                    FocusEureka.Comments(
                        id: 5,
                        onwer_id: 6,
                        user: FocusEureka.User_Comments(id: 6, username: "Jenna9223@gmail.com"),
                        post_id: 1, contents: "这个是个测试",
                        createdAt: "2023-11-30T18:55:58.291Z",
                        updatedAt: "2023-11-30T18:55:58.291Z",
                        reply_comment_id: Optional(1),
                        replyied_to: Optional("Kaifeng99890@gmail.com"),
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
                replyied_to: nil,
                reply_comment: Optional([
                ]))
        ],
        commentID: .constant(0),
        reply: .constant(""),
        isReplying: .constant(false)
    )
}
