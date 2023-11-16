//
//  ScheuleView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct ScheuleView: View {
    
    @Binding var scheduleViewModel: ScheduleViewModel
    
    var body: some View {
        if let schedules = scheduleViewModel.schedule {
            VStack {
                // single scheule view
                ForEach(schedules.scheduleDay) {element in
                    SingleScheuleView(day: element.day, isAvailable: element.isAvaliable)
                }
            }
        }
    }
}
