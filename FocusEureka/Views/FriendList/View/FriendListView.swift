//
//  FriendListView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/26/23.
//

import SwiftUI

struct FriendListView: View {
    @ObservedObject var friendListModel: FriendListModel = FriendListModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State private var keyword: String = ""
    
    @State private var showSearchFriendView: Bool = false
    @State private var showRequestFriendView: Bool = false
    
    var body: some View {
        if let friendList = self.friendListModel.filteredFriendList, friendListModel.isUpdate == false {
            VStack {
                HStack {
                    SearchBarView(placeHolder: "Search Friend", searchText: $keyword)
                    
                    // search friend sheet button
                    Button(action: {
                        self.showSearchFriendView = true
                    }, label: {
                        Image(systemName: "plus.square")
                            .resizable()
                            .foregroundStyle(Color.pink.opacity(0.9))
                            .frame(width: 30, height: 30)
                    })
                    .sheet(isPresented: self.$showSearchFriendView, content: {
                        SearchFriend()
                    })
                    .padding(.trailing)
                    
                    
                    // request friend list sheet button
                    Button(action: {
                        self.showRequestFriendView = true
                    }, label: {
                        Image(systemName: "person.bubble.fill")
                            .resizable()
                            .foregroundStyle(Color.pink.opacity(0.9))
                            .frame(width: 30, height: 30)
                    })
                    .sheet(isPresented: self.$showRequestFriendView, content: {
                        RequestFriendView()
                            // run the code inside when swap out or disppare the view
                            // use for update the firend list when user operated the
                            // accept / cancel friends
                            .onDisappear(perform: {
                                self.friendListModel.filteredFriendList = nil
                                self.friendListModel.isUpdate = true
                            })
                    })
                    .padding(.trailing)
                }
                List {
                    ForEach(friendList.indices, id: \.self) {index in
                        let currentUser = friendList[index]
                        
                        NavigationLink(destination: { OtherUserView(currentUser: currentUser)
                        }, label: {
                            UserSingleCardView(initials: currentUser.initials, fullname: currentUser.fullName)
                                .frame(height: 40)
                                .swipeActions(edge: .trailing) {
                                    Button(action: {
                                        friendListModel.deleteFriend(id: loginViewModel.currentUser!.id, friendId: currentUser.id)
                                    }, label: {
                                        Image(systemName: "trash")
                                    })
                                    .tint(.red)
                                }
                        })
                        
                    }
                }
                .listStyle(PlainListStyle())
            }
            .onChange(of: keyword) { oldValue, newValue in
                if (oldValue != newValue) {
                    friendListModel.filterFriendList(searchText: newValue)
                }
            }
            
        } else {
            Text("Loading...")
                .onAppear {
                    friendListModel.getFriendList(id: loginViewModel.currentUser!.id)
                }
        }
    }
}

#Preview {
    FriendListView()
}
