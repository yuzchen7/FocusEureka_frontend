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
    var body: some View {
        if true {
            VStack {
                ForEach(self.friendListModel.testingData.indices, id: \.self) {index in
                    let currentUser = friendListModel.testingData[index]
                    UserSingleCardView(initials: currentUser.initials, fullname: currentUser.fullName)
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
