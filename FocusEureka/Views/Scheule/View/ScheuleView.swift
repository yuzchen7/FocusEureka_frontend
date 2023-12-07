//
//  ScheuleView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct ScheuleView: View {
    
    var currentUser: User
    
    @ObservedObject var scheduleViewModel: ScheduleViewModel = ScheduleViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        if let schedules = scheduleViewModel.schedule, scheduleViewModel.isUpdate == false {
            VStack {
                // single scheule view
                ForEach(schedules.scheduleDay.indices, id: \.self) {index in
                    let element = schedules.scheduleDay[index]
                    
                    if currentUser == loginViewModel.currentUser! {
                        Button(action: {
                            scheduleViewModel.updateScheduleData(userId: self.currentUser.id, at: index, isAvaliable: !(schedules.scheduleDay[index].isAvaliable))
                        }, label: {
                            SingleScheuleView(index: index, day: element.day, isAvailable: element.isAvaliable)
                        })
                    } else {
                        SingleScheuleView(index: index, day: element.day, isAvailable: element.isAvaliable)
                    }
                }
            }
        } else {
            Text("Loading...")
                .onAppear {
                    self.scheduleViewModel.getScheduleData(userId: currentUser.id)
                }
        }
    }
}

#Preview {
    ScheuleView(currentUser: User(id: 1, username: "Kaifeng111", fristName: "Kai", middleName: "", lastName: "Feng"), scheduleViewModel: ScheduleViewModel())
}
