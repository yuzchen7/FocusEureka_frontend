//
//  OtherUserView.swift
//  FocusEureka
//
//  Created by yuz_chen on 12/5/23.
//

import SwiftUI

struct OtherUserView: View {
//    var pinterestView: [GridItem] = [
//        .init(.flexible())
//    ]
    var currentUser: User
    
    @State var isShowPost: Bool = true;
    @State var isShowSchedule: Bool = false;
    @StateObject var PostVM = PostsViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
//        NavigationStack{
        VStack{

            
            VStack() {
                
                // user information
                HStack() {
                    Text(self.currentUser.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .foregroundStyle(Color(.white))
                        .frame(width: 70, height: 70)
                        .background(Color(.systemGray))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(self.currentUser.fullName)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .padding(.top, 4)

                         Text(self.currentUser.username)
                            .font(.system(size: 16))
                            .foregroundStyle(Color(.systemPink).opacity(0.8))
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 20)
            }
            
            // button section
            Section {
                HStack(spacing: 50) {
                    // post button
                    Button(action: {
                        self.isShowPost = true
                        self.isShowSchedule = false
                    }, label: {
                        ZStack {
                            Image(systemName: "camera.viewfinder")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(isShowPost ? .pink : .black)
                                .frame(width: 35, height: 33)
                            if (self.isShowPost) {
                                Rectangle()
                                    .foregroundStyle(.pink)
                                    .frame(height: 1)
                                    .offset(y: 20)
                            }
                        }
                    })
                    .frame(width: 100)
                    
                    // schedule button
                    Button(action: {
                        self.isShowPost = false
                        self.isShowSchedule = true
                    }, label: {
                        ZStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(isShowSchedule ? .pink : .black)
                                .frame(width: 35, height: 35)
                            if (self.isShowSchedule) {
                                Rectangle()
                                    .foregroundStyle(.pink)
                                    .frame(height: 1)
                                    .offset(y: 20)
                            }
                        }
                    })
                    .frame(width: 100)
                    
                }
                .padding(.horizontal)
                .foregroundColor(Color(.black))
                
                Divider()
            }
            
            // content view section
            Section {
                if (self.isShowSchedule) {
                    ScrollView {
                        ScheuleView(currentUser: self.currentUser)
                    }
                }
                if (self.isShowPost) {
                    OtherUserPostView(postLColumn: PostVM.LColumns, postRColumn: PostVM.RColumns, friendID: self.currentUser.id)
                            .environmentObject(PostVM)
                }
            }
            .padding()
            .onAppear(){
                PostVM.loadUserPostData(userID: self.currentUser.id)
            }
            Spacer()
            
        } // VStack
    } // NavigationStack
}

#Preview {
    OtherUserView(currentUser: User(id: 1, username: "Kaifeng111", fristName: "Kai", middleName: "", lastName: "Feng"))
}
