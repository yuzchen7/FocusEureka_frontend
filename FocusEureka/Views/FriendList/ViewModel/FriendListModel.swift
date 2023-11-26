//
//  FriendListModel.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/26/23.
//

import Foundation

@MainActor
class FriendListModel: ObservableObject {
    @Published var friendList: [User]? = nil
    
    func getFriendList(id:Int) {
        
    }
}


extension FriendListModel {
    var testingData: [User] {
        get {
            return [
                User(id: 1, username: "Yuzhuang7789@gmail.com", fristName: "Yuzhuang", middleName: "null", lastName: "Chen"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
                User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
            ]
        }
    }
}
