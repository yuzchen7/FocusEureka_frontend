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
    @Published var isUpdate: Bool = false
    
    private func matchDay(day: String) -> String? {
        switch day {
            case "Sunday" :
                return "sun"
            case "Monday" :
                return "mon"
            case "Tuesday" :
                return "tue"
            case "Wednesday" :
                return "wed"
            case "Thursday" :
                return "thu"
            case "Firday" :
                return "fir"
            case "Saturday" :
                return "sat"
            default :
                return nil
        }
    }
    
    func updateScheduleData(userId: Int, at index: Int, isAvaliable: Bool) {
        Task {
            do {
                print("getScheduleData run -> ")
                let urlString: String = "https://focuseureka-backend.onrender.com/api/schedule/update"
                guard let day: String = matchDay(day: schedule!.scheduleDay[index].day) else {return}
                self.schedule = try await swiftxios.put(
                    urlString,
                    [
                        "user_id" : userId,
                        day : isAvaliable
                    ],
                    [
                        "application/json" : "Content-Type"
                    ]
                )
                // print(self.schedule ?? "nothing")
                self.isUpdate = !(self.isUpdate)
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
    
    func getScheduleData(userId: Int) {
        Task {
            do {
                print("getScheduleData run -> ")
                let urlString: String = "https://focuseureka-backend.onrender.com/api/schedule/currentUser?userId=\(userId)"
                self.schedule = try await swiftxios.get(urlString, ["application/json" : "Content-Type"])
                // print(self.schedule ?? "nothing")
                self.isUpdate = false
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
