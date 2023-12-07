//
//  SearchFriendModel.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/30/23.
//

import Foundation

@MainActor
class SearchFriendModel: ObservableObject {
    @Published var resultFriendList: [User]? = nil
    @Published var requestResult: FriendRequestResult? = nil
    
    func searchFetch(username: String) {
        Task {
            do {
                print("searchFetch run -> username : \(username)")
                let urlString: String = "https://focuseureka-backend.onrender.com/api/users/findUserAll?username=\(username)"
                self.resultFriendList = try await swiftxios.get(urlString, ["application/json" : "Content-Type"])
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
    
    func createRequestFetch(id:Int, targetId: Int) {
        Task {
            do {
                print("createRequestFetch run -> currentUser : \(id), targetId : \(targetId)")
                let urlString: String = "https://focuseureka-backend.onrender.com/api/friend_request/createRequest"
                self.requestResult = try await swiftxios.post(
                    urlString,
                    [
                        "requester" : id,
                        "accepter" : targetId
                    ],
                    [
                        "application/json" : "Content-Type"
                    ]
                )
                if let requestResult = requestResult {
                    print(requestResult)
                }
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

extension SearchFriendModel {
    static var testingData: [User]? = [
        User(id: 1, username: "Yuzhuang7789@gmail.com", fristName: "Yuzhuang", middleName: "null", lastName: "Chen"),
        User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
        User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
        User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
        User(id: 4, username: "RussellBecker9989@gmail.com", fristName: "Russell", middleName: "null", lastName: "Becker"),
    ]
}
