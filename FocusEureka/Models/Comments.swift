//
//  Comments.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import Foundation

struct Comments: Codable, Hashable{
    static func == (lhs: Comments, rhs: Comments) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id: Int
    let onwer_id: Int
    let user: User_Comments
    let post_id: Int
    let contents: String
    let createdAt: String
    let updatedAt: String
    let reply_comment_id: Int?
    let replied_to: String?
    let reply_comment:[Comments]?
}

struct User_Comments: Codable{
    let id: Int
    let username: String
}
