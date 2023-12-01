//
//  UserSingleCardView.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/26/23.
//

import SwiftUI

struct UserSingleCardView: View {
    var initials: String
    var fullname: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .foregroundStyle(.white)
//                .shadow(color: Color.black.opacity(0.5), radius: 10)
//                .frame(height: 55)
            
            HStack(spacing: 10) {
                Text(self.initials)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundStyle(Color(.white))
                    .frame(width: 35, height: 35)
                    .background(Color(.systemGray))
                    .clipShape(Circle())
                
                Text(self.fullname)
                    .font(.system(size: 18))
                    .lineLimit(1)
                    .foregroundStyle(.black)
                
                Spacer()
            }
        }
    }
}

#Preview {
    UserSingleCardView(initials: "YC", fullname: "Yuzhuang Chen")
}
