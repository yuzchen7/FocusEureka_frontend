//
//  PostLikes.swift
//  FocusEureka
//
//  Created by kai on 11/16/23.
//

import Foundation

struct PostLikes: Codable{
    let user_id: Int
    let post_id: Int
    let user: Owner?
    let message: Int?
    
}
