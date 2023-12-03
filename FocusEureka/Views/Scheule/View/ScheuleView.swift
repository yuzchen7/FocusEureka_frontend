//
//  ScheuleView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct ScheuleView: View {
    
    @ObservedObject var scheduleViewModel: ScheduleViewModel = ScheduleViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        if let schedules = scheduleViewModel.schedule, scheduleViewModel.isUpdate == false {
            VStack {
                // single scheule view
                ForEach(schedules.scheduleDay.indices, id: \.self) {index in
                    Button(action: {
                        print("Click able")
                        scheduleViewModel.updateScheduleData(userId: loginViewModel.currentUser!.id, at: index, isAvaliable: !(schedules.scheduleDay[index].isAvaliable))
                        print(schedules.scheduleDay)
                    }, label: {
                        let element = schedules.scheduleDay[index]
                        SingleScheuleView(index: index, day: element.day, isAvailable: element.isAvaliable)
                    })
                }
            }
        } else {
            Text("Loading...")
                .onAppear {
                    self.scheduleViewModel.getScheduleData(userId: loginViewModel.currentUser!.id)
                }
        }
    }
}

#Preview {
    ScheuleView(scheduleViewModel: ScheduleViewModel())
}
