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
    
    var body: some View {
        if let friendList = friendListModel.filteredFriendList, friendListModel.isUpdate == false {
            VStack {
                SearchBarView(placeHolder: "Search Friend", searchText: $keyword)
                List {
                    ForEach(friendList.indices, id: \.self) {index in
                        let currentUser = friendList[index]
                        UserSingleCardView(initials: currentUser.initials, fullname: currentUser.fullName)
                            .swipeActions(edge: .trailing) {
                                Button(action: {
                                    friendListModel.deleteFriend(id: loginViewModel.currentUser!.id, friendId: currentUser.id)
                                }, label: {
                                    Text("Delete")
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
