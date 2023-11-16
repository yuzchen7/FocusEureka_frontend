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
