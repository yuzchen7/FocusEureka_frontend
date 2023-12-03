//
//  FriendAcceptResult.swift
//  FocusEureka
//
//  Created by yuz_chen on 12/2/23.
//

import Foundation

struct FriendAcceptResult:Codable {
    var result: Bool
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result = "result",
             errorMessage = "message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try container.decode(Bool.self, forKey: .result)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}
