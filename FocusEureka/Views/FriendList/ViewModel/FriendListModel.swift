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
    @Published var filteredFriendList: [User]? = nil
    
    @Published var isUpdate: Bool = false
    
    func filterFriendList(searchText: String) {
        if let friends = friendList {
            if searchText.isEmpty {
                self.filteredFriendList = friends
            } else {
                self.filteredFriendList = friends.filter { friend in
                    return friend.fullName.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
    
    func getFriendList(id:Int) {
        Task {
            do {
                print("getFriendList run -> current user id:\(id)")
                let urlString: String = "http://localhost:8080/api/users/friendList?onwerid=\(id)"
                print("url -> \(urlString)")
                self.friendList = try await swiftxios.get(urlString, ["application/json" : "Content-Type"])
                self.filteredFriendList = self.friendList
                self.isUpdate = false
            } catch Swiftxios.FetchError.invalidURL {
                print("function getScheduleData from class Swiftxios has URL error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidResponse {
                print("function getScheduleData from class Swiftxios has HttpResponse error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidData {
                print("function getScheduleData from class Swiftxios has response Data error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidObjectConvert {
                print("function getScheduleData from class Swiftxios has Converting Data error (╯’ – ‘)╯︵")
            } catch {
                print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
            }
        }
    }
    
    func deleteFriend(id:Int, friendId: Int) {
        Task {
            do {
                print("deleteFriend run -> current user id:\(id), friend id \(friendId)")
                let urlString: String = "http://localhost:8080/api/friend_request?currentUser=\(id)&friend=\(friendId)"
                print("url -> \(urlString)")
                let row: Int? = try await swiftxios.delete(urlString, ["application/json" : "Content-Type"])
                if let row = row, row <= 0 {
                    print("delete error happen -> invalied delete")
                    return
                }
                self.isUpdate = !self.isUpdate
                return
            } catch Swiftxios.FetchError.invalidURL {
                print("function getScheduleData from class Swiftxios has URL error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidResponse {
                print("function getScheduleData from class Swiftxios has HttpResponse error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidData {
                print("function getScheduleData from class Swiftxios has response Data error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidObjectConvert {
                print("function getScheduleData from class Swiftxios has Converting Data error (╯’ – ‘)╯︵")
            } catch {
                print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
            }
        }
    }
}


extension FriendListModel {
    static var testingData: [User]? = [
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
