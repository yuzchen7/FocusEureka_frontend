//
//  SearchBarView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/28/23.
//

import SwiftUI

struct SearchBarView: View {
    var placeHolder : String
    @Binding var searchText: String
    
    var body: some View {
        ZStack {            
            TextField(placeHolder, text: $searchText)
                .lineLimit(1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
}

#Preview {
    SearchBarView(placeHolder: "Search Friend", searchText: .constant(""))
}
