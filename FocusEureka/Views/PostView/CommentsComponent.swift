//
//  CommentsComponent.swift
//  FocusEureka
//
//  Created by kai on 11/19/23.
//

import SwiftUI

struct CommentsComponent: View {
    var commentsToPost:[Comments]
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
                    HStack(alignment: .top,spacing: 20){
                        VStack{
                            Image(systemName: "person.crop.circle")
                        }
                        VStack(alignment: .leading){
                            Text("\(comment.contents)")
                            ForEach(comment.reply_comment ?? [], id: \.self){ replys in
                                HStack(spacing: 20){
                                    VStack{
                                        Image(systemName: "person.crop.circle")
                                    }
                                    Text("\(replys.contents)")
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
    CommentsComponent(commentsToPost: [
        Comments(
            id: 1, 
            onwer_id: 1,
            post_id: 1,
            contents: "Very excited about the event...",
            createdAt: "2023-11-19T21:33:50.298Z",
            updatedAt: "2023-11-19T21:33:50.298Z",
            reply_comment_id: nil,
            reply_comment: Optional([FocusEureka.Comments(
                id: 2,
                onwer_id: 2,
                post_id: 1,
                contents: "cant wait to see the event...",
                createdAt: "2023-11-19T21:33:50.298Z",
                updatedAt: "2023-11-19T21:33:50.298Z",
                reply_comment_id: Optional(1),
                reply_comment: nil)])
        ), 
        Comments(
            id: 4,
            onwer_id: 3,
            post_id: 1,
            contents: "testing testing",
            createdAt: "2023-11-19T21:33:50.298Z",
            updatedAt: "2023-11-19T21:33:50.298Z",
            reply_comment_id: nil,
            reply_comment: Optional([
            ]))
    ])
}
