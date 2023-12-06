//
//  PostsViewModel.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import Foundation
import SwiftUI

enum postState{
    case general, events, spots
}

@MainActor
class PostsViewModel : ObservableObject{
    @Published var viewState = postState.general
    var posts = [Posts]()
    @Published var RColumns = [Posts]()
    @Published var LColumns = [Posts]()
    @Published var singlePost:Posts?
    @Published var title = "Discover & Enjoy"
    @State var fetchedComment:Comments?
    var likesRes:PostLikes?
    let baseURL =  "http://localhost:8080/api/posts/"
    
    
    func fetchSinglePost(postID: Int) async throws {
        guard let url = URL(string: baseURL + "singleView?postId=\(postID)") else {
            return
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let fetchedPost = try JSONDecoder().decode(Posts.self, from: data)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        let date = formatter.date(from: fetchedPost.createdAt)
        _ = Calendar.current.date(byAdding: .hour, value: -5, to: date!)
        singlePost = fetchedPost
        singlePost?.createdAt = date!.formatted(date: .long, time: .shortened)
    }
    
    func addLikes(postID: Int, userID: Int) async throws{
        do{
            likesRes = try await swiftxios.post(
                "http://localhost:8080/api/posts/Likes",
                [
                    "post_id" : postID,
                    "user_id" : userID
                ],
                [
                    "application/json" : "Content-Type"
                ]
            )
        }catch Swiftxios.FetchError.invalidURL {
            print("function signIn from class Swiftxios has URL error (╯’ – ‘)╯︵")
        } catch Swiftxios.FetchError.invalidResponse {
            print("function signIn from class Swiftxios has HttpResponse error (╯’ – ‘)╯︵")
        } catch Swiftxios.FetchError.invalidData {
            print("function signIn from class Swiftxios has response Data error (╯’ – ‘)╯︵")
        } catch Swiftxios.FetchError.invalidObjectConvert {
            print("function signIn from class Swiftxios has Converting Data error (╯’ – ‘)╯︵")
        } catch {
            print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
        }
        loadPostData()
        try await fetchSinglePost(postID: postID)
    }
}

extension PostsViewModel{
    //network calling to backend
    func fetchAllPosts() async throws{
        guard let url = URL(string:baseURL) else{
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedPosts = try JSONDecoder().decode([Posts].self, from: data)
            self.posts = fetchedPosts
        } catch {
            print("Error: \(error)")
        }
    }
    
    func loadPostData() {
        Task (priority: .medium){
            posts.removeAll()
            var LC = [Posts]()
            var RC = [Posts]()
            switch viewState {
            case .general:
                try await fetchAllPosts()
            case .events:
                try await fetchEventPosts(postState: "true")
            case .spots:
                try await fetchEventPosts(postState: "false")
            }
            var counter = 0
            for fetchedPost in posts{
                if(counter%2==0){
                    LC.append(fetchedPost)
                }
                else{
                    RC.append(fetchedPost)

                }
                counter+=1
            }
            LColumns = LC
            RColumns = RC
        }
    }
}

//switch post view type feature
extension PostsViewModel{
    
    func switchPostType(){
        if(viewState == .general){
            viewState = .events
            title = "Events"
        }else if(viewState == .events){
            viewState = .spots
            title = "Spots"
        }else{
            viewState = .general
            title = "Discover & Enjoy"
        }
        loadPostData()
    }
    
    func fetchEventPosts(postState: String) async throws{
        guard let url = URL(string: baseURL + "event?lookForEvent=\(postState)") else{
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedPosts = try JSONDecoder().decode([Posts].self, from: data)
            self.posts = fetchedPosts
        } catch {
            print("Error: \(error)")
        }
    }
}


//comments feature
extension PostsViewModel{
    
    func userInputComment(userID: Int, postID: Int, userInput: String) async throws{
        fetchedComment = try await swiftxios.post(
            "http://localhost:8080/api/comments/write",
            [
                "onwer_id":userID,
                "post_id":postID,
                "contents":userInput
                
            ],
            [
                "application/json" : "Content-Type"
            ]
        )
        try await fetchSinglePost(postID: postID)
    }
    
    func userInputReply(userID: Int, postID: Int, userInput: String, replyID:Int) async throws{
        fetchedComment = try await swiftxios.post(
            "http://localhost:8080/api/comments/write",
            [
                "onwer_id":userID,
                "post_id":postID,
                "contents":userInput,
                "reply_comment_id": replyID
                
            ],
            [
                "application/json" : "Content-Type"
            ]
        )
        try await fetchSinglePost(postID: postID)
    }
    
    func replyToResponse(userID: Int, postID: Int, userInput: String, replyID:Int, userReplied: String) async throws{
        fetchedComment = try await swiftxios.post(
            "http://localhost:8080/api/comments/write",
            [
                "onwer_id": userID,
                "post_id": postID,
                "contents": userInput,
                "reply_comment_id": replyID,
                "replied_to": userReplied
            ],
            [
                "application/json" : "Content-Type"
            ]
        )
        try await fetchSinglePost(postID: postID)
    }
}

//current user & friend personal posts
extension PostsViewModel{
    //network calling to backend
    func fetchUserPosts(ID: Int) async throws{
        guard let url = URL(string:baseURL + "user?userId=\(ID)") else{
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedPosts = try JSONDecoder().decode([Posts].self, from: data)
            self.posts = fetchedPosts
        } catch {
            print("Error: \(error)")
        }
    }
    
    func loadUserPostData(userID: Int) {
        Task (priority: .medium){
            posts.removeAll()
            var LC = [Posts]()
            var RC = [Posts]()
            try await fetchUserPosts(ID:userID)
            var counter = 0
            for fetchedPost in posts{
                if(counter%2==0){
                    LC.append(fetchedPost)
                }
                else{
                    RC.append(fetchedPost)

                }
                counter+=1
            }
            LColumns = LC
            RColumns = RC
        }
    }
    
    func userAddLikes(postID: Int, userID: Int) async throws{
        do{
            likesRes = try await swiftxios.post(
                "http://localhost:8080/api/posts/Likes",
                [
                    "post_id" : postID,
                    "user_id" : userID
                ],
                [
                    "application/json" : "Content-Type"
                ]
            )
        }catch Swiftxios.FetchError.invalidURL {
            print("function signIn from class Swiftxios has URL error (╯’ – ‘)╯︵")
        } catch Swiftxios.FetchError.invalidResponse {
            print("function signIn from class Swiftxios has HttpResponse error (╯’ – ‘)╯︵")
        } catch Swiftxios.FetchError.invalidData {
            print("function signIn from class Swiftxios has response Data error (╯’ – ‘)╯︵")
        } catch Swiftxios.FetchError.invalidObjectConvert {
            print("function signIn from class Swiftxios has Converting Data error (╯’ – ‘)╯︵")
        } catch {
            print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
        }
        loadUserPostData(userID: userID)
        try await fetchSinglePost(postID: postID)
    }
}
