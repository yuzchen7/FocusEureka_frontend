//
//  AccountView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State var isShowPost: Bool = true;
    @State var isShowSchedule: Bool = false;
    @State var isShowFriendList: Bool = false;
    
    var body: some View {
        if let currentUser = self.loginViewModel.currentUser {
            NavigationStack{
                ScrollView {
                    VStack() {
                        
                        Text("FocusEureka!!")
                            .font(.system(size: 25))
                            .foregroundStyle(.pink)
                            .padding(.top, 10)
                        
                        // user information
                        HStack() {
                            Text(currentUser.initials)
                            // Text("YC")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.white))
                                .frame(width: 70, height: 70)
                                .background(Color(.systemGray))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(currentUser.fullName)
                                  // Text("Yuzhuang Chen")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text(currentUser.username)
                                // Text("yuzchen")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(.systemGray))
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: {
                                ProfileView()
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(style: /*@START_MENU_TOKEN@*/StrokeStyle()/*@END_MENU_TOKEN@*/)
                                        .frame(width: 55, height: 25)
                                    
                                    Text("Edit")
                                }
                                .foregroundStyle(.black)
                                .padding(.horizontal)
                                // SettingRowView(image: "gear", title: "", tinColor: Color(.systemGray))
                            })
                            
                        }
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom, 20)
                    }
                    
                    Section {
                        HStack {
                            // post button
                            Button(action: {
                                self.isShowPost = true
                                self.isShowSchedule = false
                                self.isShowFriendList = false
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
                                self.isShowFriendList = false
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
                            
                            // friend list button
                            Button(action: {
                                self.isShowPost = false
                                self.isShowSchedule = false
                                self.isShowFriendList = true
                            }, label: {
                                ZStack {
                                    Image(systemName: "person.2.crop.square.stack.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(isShowFriendList ? .pink : .black)
                                        .frame(width: 35, height: 35)
                                    if (self.isShowFriendList) {
                                        Rectangle()
                                            .foregroundStyle(.pink)
                                            .frame(height: 1)
                                            .offset(y: 20)
                                    }
                                }
                            })
                            .frame(width: 100)
                        }
                        .foregroundColor(Color(.black))
                    }
                    
                    // content view section
                    Section {
                        if (self.isShowSchedule) {
                            ScheuleView()
                        }
                        
                        if (self.isShowFriendList) {
                            Text("Friend List")
                            // TODO:
                            // display FriendList page
                        }
                    }
                    .padding(.top)
                    .padding()
                    
                    
                } // VStack
            } // ScrollView
        } // NavigationStack
    } // if currentuser
}

#Preview {
    AccountView()
}
