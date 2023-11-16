//
//  SingleScheuleView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct SingleScheuleView: View {
    var day: String
    var isAvailable: Bool
    
    var body: some View {
        HStack{
            Rectangle()
                .frame(width: 10)
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .imageScale(.large)
            // .padding(.trailing)
            
            HStack {
                Text(self.day)
                    .font(.title)
                    .foregroundStyle(Color.black)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("Avalible")
                    .foregroundStyle(Color(.systemGreen))
                    .padding(.trailing)
            }
        }
        .frame(height: 70)
        .foregroundStyle(Color(.systemGray))
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
}

#Preview {
    SingleScheuleView(day: "Snnday", isAvailable: true)
}


