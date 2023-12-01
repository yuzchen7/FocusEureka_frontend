//
//  RequestFriendView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/30/23.
//

import SwiftUI

struct RequestFriendView: View {
    @ObservedObject var requestFriendModel: RequestFriendModel = RequestFriendModel()
    
    var body: some View {
        VStack {
            Text("Search Friends").font(.title2).foregroundStyle(.pink)
            
            if let resultfriendList = RequestFriendModel.testingData, !resultfriendList.isEmpty {
                List {
                    ForEach(resultfriendList.indices, id: \.self) {index in
                        let currentUser = resultfriendList[index]
                        
                        Button(action: {
                            
                        }, label: {
                            ZStack {
                                UserSingleCardView(initials: currentUser.initials, fullname: currentUser.fullName)
                                    .frame(height: 40)
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        
                                    }, label: {
                                        Image(systemName: "plus.app")
                                            .resizable()
                                            .foregroundStyle(Color.pink.opacity(0.8))
                                            .frame(width: 30, height: 30)
                                            .padding(.horizontal)
                                    })
                                }
                            }
                        })
                    }
                }
                .listStyle(PlainListStyle())
                
            } else {
                
            }
        }
        .padding(.top)
    }
}

#Preview {
    RequestFriendView()
}
