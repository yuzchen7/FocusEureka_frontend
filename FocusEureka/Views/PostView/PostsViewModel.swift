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
    //array to store data fetched from backend
    @Published var viewState = postState.general
    @Published var posts = [Posts]()
//    @Published var singlePost:Posts = MockData.dummyPost
    @Published var RColumns = [Posts]()
    @Published var LColumns = [Posts]()
    @Published var singlePost:Posts?
    @Published var title = "Discover & Enjoy"
    var likesRes:PostLikes?
    let baseURL =  "http://localhost:8080/api/posts/"
    
    
    func fetchSinglePost(postID: Int) async throws {
        guard let url = URL(string: baseURL + "singleView?postId=\(postID)") else {
            return
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let fetchedPost = try JSONDecoder().decode(Posts.self, from: data)
        singlePost = fetchedPost
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
//            LColumns.removeAll()
//            RColumns.removeAll()
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
//                    LColumns.append(fetchedPost)
                    LC.append(fetchedPost)
                }
                else{
//                    RColumns.append(fetchedPost)
                    RC.append(fetchedPost)

                }
                counter+=1
            }
            LColumns = LC
            RColumns = RC
        }
    }
}

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
