//
//  Schedule.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import Foundation

struct Schedule: Identifiable, Codable {
    var id: Int
    var scheduleDay: [ScheduleDay];
    
    enum CodingKeys:  String, CodingKey {
        case id = "user_id",
             scheduleDay = "schedules"
    }
    
}

struct ScheduleDay: Identifiable, Codable {
    var id: Int = UUID().hashValue
    var day: String
    var isAvaliable: Bool
    
    enum CodingKeys:  String, CodingKey {
        case day = "day",
             isAvaliable = "isAvaliable"
    }
    
}
