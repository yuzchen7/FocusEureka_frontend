//
//  SettingRowView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct SettingRowView: View {
    var image: String;
    var title: String;
    var tinColor: Color;
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: self.image)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(self.tinColor)
            
            Text(self.title)
                .font(.subheadline)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    SettingRowView(image: "gear", title: "Version", tinColor: Color(.systemGray))
}
