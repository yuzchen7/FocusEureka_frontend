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
    let post_id: Int
    let contents: String
    let createdAt: String
    let updatedAt: String
    let reply_comment_id: Int?
    let reply_comment:[Comments]?
    
}
