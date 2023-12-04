//
//  Posts.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import Foundation

import SwiftUI

struct Posts: Codable, Identifiable, Hashable{
    static func == (lhs: Posts, rhs: Posts) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id: Int
    let title: String
    let contents: String
    let address: String
    let city: String
    let state: String
    let zipcode: String
    let start_date: String?
    let start_time: String?
    let end_date: String?
    let end_time: String?
    let ownerid: Int
    let event: Bool
    var createdAt: String
    let updatedAt: String
    let image_set: Image_set
    let owner: Owner
    let post_likes: [PostLikes]?
    let comments:[Comments]?
}

struct MockData {
    static let dummyPost = Posts(
        id: 6,
        title: "Kinokuniya",
        contents: "Azaming book shop where you can buy manga and figures for your favorite anime",
        address: "1073 Avenue of the Americas",
        city: "New York",
        state: "NY",
        zipcode: "10018",
        start_date: nil,
        start_time: Optional("10:00"),
        end_date: nil,
        end_time: Optional("20:00"),
        ownerid: 2,
        event: false,
        createdAt: "2023-11-02T23:12:16.781Z",
        updatedAt: "2023-11-02T23:12:16.781Z",
        image_set: FocusEureka.Image_set(
            post_id: 6,
            urls: ["https://images.squarespace-cdn.com/content/v1/571abd61e3214001fb3b9966/1518814837468-LZXSJ9HHAUX6YEDZQMF9/entrance.jpg?format=2500w", "https://images.squarespace-cdn.com/content/v1/571abd61e3214001fb3b9966/1518814402334-EDMWCIKTFR4TDOSG0SVP/IMG_1374.jpg?format=2500w"]),
        owner: FocusEureka.Owner(
            id: 2,
            first_name: "Kaifeng",
            last_name: "Yu",
            middle_name: nil,
            username: "Kaifeng99890@gmail.com"),
        post_likes: nil,
        comments: nil)
}
