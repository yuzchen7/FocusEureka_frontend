//
//  RequestReslut.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/30/23.
//

import Foundation

struct RequestReslut:Codable {
    var requester: Int?
    var accepter: Int?
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case requester = "ownerid",
             accepter = "targetid",
             errorMessage = "message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requester = try container.decodeIfPresent(Int.self, forKey: .requester)
        self.accepter = try container.decodeIfPresent(Int.self, forKey: .accepter)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}
