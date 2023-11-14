//
//  SwiftxiosCodeable.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/14/23.
//

import Foundation

extension Swiftxios {
    func swiftxiosJSONDecoder<T: Codable>(data: Data?) throws -> T? {
        if let data = data {
            return try JSONDecoder().decode(T.self, from: data);
        }
        
        return nil
    }
}
