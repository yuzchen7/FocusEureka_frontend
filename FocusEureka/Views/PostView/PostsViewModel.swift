//
//  PostsViewModel.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import Foundation

@MainActor
class PostsViewModel : ObservableObject{
    //array to store data fetched from backend
    @Published var posts = [Posts]()
//    @Published var singlePost:Posts = MockData.dummyPost
    @Published var singlePost:Posts?
    var likesRes:PostLikes?
    let baseURL =  "http://localhost:8080/api/posts/"
    
    init (){
        loadData()
    }
    
    func handleRefreash(){
        posts.removeAll()
        loadData()
    }
    
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
                "http://localhost:8080/api/posts/create",
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
    
    func loadData() {
        Task (priority: .medium){
            try await fetchAllPosts()
        }
    }
}
