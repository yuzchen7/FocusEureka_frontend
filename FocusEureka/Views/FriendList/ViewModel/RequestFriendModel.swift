//
//  RequestFriendModel.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/30/23.
//

import Foundation

@MainActor
class RequestFriendModel: ObservableObject {
    @Published var requestFriendList: [User]? = nil

    func requestFriendFetch(id: Int) {
        Task {
            do {
                print("requestFriendFetch run -> user ID : \(id)")
                let urlString: String = "http://localhost:8080/api/friend_request/receiving?targetid=\(id)"
                self.requestFriendList = try await swiftxios.get(urlString, ["application/json" : "Content-Type"])
            } catch Swiftxios.FetchError.invalidURL {
                print("function requestFriendFetch from class Swiftxios has URL error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidResponse {
                print("function requestFriendFetch from class Swiftxios has HttpResponse error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidData {
                print("function requestFriendFetch from class Swiftxios has response Data error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidObjectConvert {
                print("function requestFriendFetch from class Swiftxios has Converting Data error (╯’ – ‘)╯︵")
            } catch {
                print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
            }
        }
    }
}

extension RequestFriendModel {
    static var testingData: [User]? = [
        User(id: 1, username: "Yuzhuang7789@gmail.com", fristName: "Yuzhuang", middleName: "null", lastName: "Chen"),
        User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
        User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
        User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
        User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
    ]
}
