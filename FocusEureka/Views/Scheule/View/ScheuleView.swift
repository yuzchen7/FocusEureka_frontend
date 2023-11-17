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
        if let schedules = scheduleViewModel.schedule {
            VStack {
                // single scheule view
                ForEach(schedules.scheduleDay) {element in
                    SingleScheuleView(day: element.day, isAvailable: element.isAvaliable)
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
