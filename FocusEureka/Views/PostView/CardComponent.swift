//
//  CardView.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI

struct CardComponent: View {
//    @StateObject var postVM = PostsViewModel()
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
                }
                VStack{
                    Button(
                        action: {
                            Task{
                                try await postVM.addLikes(postID: postId, userID: userId)
                            }
                        },
                        label: {
                            Image(systemName: "heart.circle")
                            Text("\(Likes)")
                        })
                }
            }
            HStack{
                Text("\(posterName)")
            }
        }
        .background(.white)
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width/2-10)
        .padding(5)
        .shadow(radius: 1)
    }
}

#Preview {
    CardComponent(imageURL:"https://images.squarespace-cdn.com/content/v1/571abd61e3214001fb3b9966/1518814837468-LZXSJ9HHAUX6YEDZQMF9/entrance.jpg?format=2500w",
             title:"Kinokuniya",
             Likes:6,
             posterName:"anonymous",
             postId: 6,
             userId: 2
    )
}
