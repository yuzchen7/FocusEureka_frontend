//
//  User.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import Foundation

struct User: Identifiable, Codable, Equatable, Hashable{
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int;
    let username: String;
    let fristName: String;
    let middleName: String;
    let lastName: String;
    private var password: String = "";
    
    init(id: Int, username: String, fristName: String, middleName: String, lastName: String) {
        self.id = id
        self.username = username
        self.fristName = fristName
        self.middleName = middleName
        self.lastName = lastName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.username = try container.decode(String.self, forKey: .username)
        // self.fristName = try container.decode(String.self, forKey: .fristName)
        // self.middleName = try container.decode(String.self, forKey: .middleName)
        // self.lastName = try container.decode(String.self, forKey: .lastName)
        
        if let fname = try? container.decode(String.self, forKey: .fristName), fname != "null" {
            self.fristName = fname;
        } else {
            self.fristName = "";
        }
        
        if let mname = try? container.decode(String.self, forKey: .middleName), mname != "null" {
            self.middleName = mname
        } else {
            self.middleName = ""
        }
        
        if let lname = try? container.decode(String.self, forKey: .lastName), lname != "null" {
            self.lastName = lname;
        } else {
            self.lastName = "";
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id",
             username = "username",
             fristName = "first_name",
             middleName = "middle_name",
             lastName = "last_name"
    }
    
    var fullName: String {
        get {
            return self.fristName + " " + (self.middleName == "null" ? "" : self.middleName + " ") + self.lastName
        }
    }
    
    var initials: String {
        get {
            let formatter = PersonNameComponentsFormatter();
            if let components = formatter.personNameComponents(from: self.fullName) {
                formatter.style = .abbreviated
                return formatter.string(from: components)
            }
            return ""
        }
    }
    
    mutating func setPassword(password: String) -> Void {
        self.password = password
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.fullName == rhs.fullName
    }
}

// testing data
extension User {
    static var MOCK_USER = User(id: 67656474246, username: "MaryJaneWatson", fristName: "Mary", middleName: "Jane", lastName: "Watsont")
}

