//
//  InputComponentView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/16/23.
//

import SwiftUI

struct InputComponentView: View {
    @Binding var inputText: String
    var title: String
    var placeHolder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(self.title)
                .font(.system(size: 14))
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
            
            if (self.isSecureField) {
                SecureField(self.placeHolder, text: self.$inputText)
                    .font(.system(size: 14));
            } else {
                TextField(self.placeHolder, text: self.$inputText)
                    .font(.system(size: 14));
            }
            
            Divider();
        }
    }
}

#Preview {
    InputComponentView(inputText: .constant(""), title: "Username", placeHolder: "Enter your username", isSecureField: false)
}

