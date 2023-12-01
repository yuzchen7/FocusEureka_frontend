//
//  SearchFriend.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/30/23.
//

import SwiftUI

struct SearchFriend: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var searchFriendModel: SearchFriendModel = SearchFriendModel()
    @State var targetUsername: String = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Search Friends").font(.title2).foregroundStyle(.pink)
            
            SearchBarView(placeHolder: "Enter Username", searchText: self.$targetUsername)
            
            if let resultfriendList = searchFriendModel.resultFriendList, !resultfriendList.isEmpty {
                List {
                    ForEach(resultfriendList.indices, id: \.self) {index in
                        let pendingTarget = resultfriendList[index]
                        
                        HStack {
                            UserSingleCardView(initials: pendingTarget.initials, fullname: pendingTarget.fullName)
                                .frame(height: 40)
                            
                            Button(action: {
                                searchFriendModel.createRequestFetch(id: loginViewModel.currentUser!.id, targetId: pendingTarget.id)
                                showAlert = true
                            }, label: {
                                Image(systemName: "plus.app")
                                    .resizable()
                                    .foregroundStyle(Color.pink.opacity(0.8))
                                    .frame(width: 30, height: 30)
                                    .padding(.horizontal)
                            })
                            .alert(isPresented: self.$showAlert , content: {
                                Alert(
                                    title: Text("Add Friends"),
                                    message: Text(self.searchFriendModel.requestResult?.errorMessage ?? "Add Friends successfully, waiting your friend respond"),
                                    primaryButton: .default(Text("OK"), action: {
                                        showAlert = false
                                    }),
                                    secondaryButton: .cancel(Text("Cancel")) // 可选：添加取消按钮
                                )
                            })
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
            } else if let resultFriendList = searchFriendModel.resultFriendList, resultFriendList.isEmpty, self.targetUsername != "" {
                VStack {
                    Text("No User are find base on our record")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundStyle(Color.pink.opacity(0.8))
                }
                .padding(.top)
                Spacer()
                
            } else {
                VStack {
                    Text("Enter your friend's username in the search bar.")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundStyle(Color.pink.opacity(0.8))
                }.padding(.top)
                Spacer()
            }
        }
        .padding(.top)
        .onChange(of: targetUsername) { oldValue, newValue in
            if (oldValue != newValue && newValue != "") {
                searchFriendModel.searchFetch(username: newValue)
            }
        }
    }
}

#Preview {
    SearchFriend()
}
