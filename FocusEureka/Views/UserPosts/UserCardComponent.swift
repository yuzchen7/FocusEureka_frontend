//
//  UserCardComponent.swift
//  FocusEureka
//
//  Created by kai on 12/5/23.
//

import SwiftUI

struct UserCardComponent: View {
        @EnvironmentObject var postVM : PostsViewModel
        var imageURL:String
        var title:String
        var Likes:Int
        var posterName:String
        var postId:Int
        var userId:Int
        var body: some View {
            VStack(spacing:10){
                HStack{
                    AsyncImage(url: URL(string: imageURL)) { fetchedImage in
                        fetchedImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100,height: 100)
                    }
                }
                HStack{
                    VStack{
                        Text("\(title)")
                            .lineLimit(1)
                    }
                    VStack{
                        Button(
                            action: {
                                Task{
                                    try await postVM.userAddLikes(postID: postId, userID: userId)
                                }
                            },
                            label: {
                                HStack(spacing:3){
                                    Image(systemName: "heart.circle")
                                    Text("\(Likes)")
                                }

                            })
                    }
                }
                HStack{
                    Text("\(posterName)")
                }
            }
            .background(.white)
            .cornerRadius(10)
            .frame(width: UIScreen.main.bounds.width/2-30)
            .padding(5)
            .shadow(radius: 1)
        }

}

#Preview {
    UserCardComponent(imageURL:"https://images.squarespace-cdn.com/content/v1/571abd61e3214001fb3b9966/1518814837468-LZXSJ9HHAUX6YEDZQMF9/entrance.jpg?format=2500w",
                      title:"Kinokuniya",
                      Likes:6,
                      posterName:"anonymous",
                      postId: 6,
                      userId: 2)
}
