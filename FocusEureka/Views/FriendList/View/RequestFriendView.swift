//
//  RequestFriendView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/30/23.
//

import SwiftUI

struct RequestFriendView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var requestFriendModel: RequestFriendModel = RequestFriendModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Request pending Friends List").font(.title2).foregroundStyle(.pink)
            
            if let requestFriendList = self.requestFriendModel.requestFriendList,
               self.requestFriendModel.isUpdate == false {
                
                if requestFriendList.isEmpty {
                    VStack {
                        Text("There is no friend request from orthers")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundStyle(Color.pink.opacity(0.8))
                    }
                    .padding(.top)
                    Spacer()
                } else {
                    List {
                        ForEach(requestFriendList.indices, id: \.self) {index in
                            let currentUser = requestFriendList[index]
                            
                            ZStack {
                                UserSingleCardView(initials: currentUser.initials, fullname: currentUser.fullName)
                                    .frame(height: 40)
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        self.requestFriendModel.acceptFriendRequestFetch(id: self.loginViewModel.currentUser!.id, targetID: currentUser.id)
                                    }, label: {
                                        Image(systemName: "plus.app")
                                            .resizable()
                                            .foregroundStyle(Color.pink.opacity(0.8))
                                            .frame(width: 30, height: 30)
                                            .padding(.horizontal)
                                    })
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Dismiss")
                        .font(.system(size: 25))
                        .fontWeight(.light)
                        .padding(.horizontal)
                })
                .frame(height: 35)
                .background(
                    RoundedRectangle(cornerRadius: 5) // 圆角矩形作为背景
                        .stroke(Color.pink.opacity(0.3), lineWidth: 1) // 边框样式
                )
                .foregroundStyle(Color.pink.opacity(0.9))
                
            } else {
                Text("Loading...")
                    .onAppear {
                        self.requestFriendModel.requestFriendFetch(id: self.loginViewModel.currentUser!.id)
                    }
            }
        }
        .padding(.top)
    }
}

#Preview {
    RequestFriendView()
}
