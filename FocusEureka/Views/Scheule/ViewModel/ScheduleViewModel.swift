//
//  ScheuleViewModel.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import Foundation

@MainActor
class ScheduleViewModel: ObservableObject {
    
    @Published var schedule: Schedule? = nil
    
    func getScheduleData(userId: Int) {
        Task {
            do {
                print("getScheduleData run -> ")
                let urlString: String = "http://localhost:8080/api/schedule/currentUser?userId=\(userId)"
                self.schedule = try await swiftxios.get(urlString, ["application/json" : "Content-Type"])
                print(self.schedule ?? "nothing")
            } catch Swiftxios.FetchError.invalidURL {
                print("function getScheduleData from class Swiftxios has URL error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidResponse {
                print("function getScheduleData from class Swiftxios has HttpResponse error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidData {
                print("function getScheduleData from class Swiftxios has response Data error (╯’ – ‘)╯︵")
            } catch Swiftxios.FetchError.invalidObjectConvert {
                print("function getScheduleData from class Swiftxios has Converting Data error (╯’ – ‘)╯︵")
            } catch {
                print("unknow error -> unexpected \(error.localizedDescription) (╯’ – ‘)╯︵")
            }
        }
    }
}
