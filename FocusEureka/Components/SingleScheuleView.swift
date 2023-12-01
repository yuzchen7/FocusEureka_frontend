//
//  SingleScheuleView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct SingleScheuleView: View {
    var index: Int
    var day: String
    @State var isAvailable: Bool
    
    var body: some View {
        HStack{
            Rectangle()
                .fill(isAvailable ? .green : .red)
                .frame(width: 10)
            
            Image(systemName: self.isAvailable ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(self.isAvailable ? .green : .red)
                .imageScale(.large)
            // .padding(.trailing)
            
            HStack {
                Text(self.day)
                    .font(.title)
                    .foregroundStyle(Color.black)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(self.isAvailable ? "Avalible" : "Not Avalible")
                    .foregroundStyle(Color(self.isAvailable ? .systemGreen : .systemRed))
                    .padding(.trailing)
            }
        }
        .frame(height: 65)
        .foregroundStyle(Color(.systemGray))
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
}

#Preview {
    SingleScheuleView(index: 0, day: "Snnday", isAvailable: true)
}


