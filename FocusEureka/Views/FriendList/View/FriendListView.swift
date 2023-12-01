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
    
    var body: some View {
        if let friendList = self.friendListModel.filteredFriendList, friendListModel.isUpdate == false {
            VStack {
                HStack {
                    SearchBarView(placeHolder: "Search Friend", searchText: $keyword)
                    
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
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "person.bubble.fill")
                            .resizable()
                            .foregroundStyle(Color.pink.opacity(0.9))
                            .frame(width: 30, height: 30)
                    })
                    .padding(.trailing)
                }
                List {
                    ForEach(friendList.indices, id: \.self) {index in
                        let currentUser = friendList[index]
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
