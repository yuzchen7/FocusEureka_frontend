//
//  CardView.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import SwiftUI

struct CardView: View {
    var imageURL:String
    var title:String
    var Likes:Int
    var posterName:String
    var body: some View {
        VStack(spacing:10){
            HStack{
                AsyncImage(url: URL(string: imageURL)) { fetchedImage in
                    fetchedImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            }
            HStack{
                VStack{
                    Text("\(title)")
                }
                VStack{
                    Button(
                        action: {
                            //add Likes
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
        .frame(width: UIScreen.main.bounds.width/2-25)
        .padding()
    }
}

#Preview {
    CardView(imageURL:"https://images.squarespace-cdn.com/content/v1/571abd61e3214001fb3b9966/1518814837468-LZXSJ9HHAUX6YEDZQMF9/entrance.jpg?format=2500w",
         title:"Kinokuniya",
         Likes:6,
         posterName:"anonymous"
    )
}
