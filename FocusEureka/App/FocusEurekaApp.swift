//
//  FocusEurekaApp.swift
//  FocusEureka
//
//  Created by yuz_chen on 11/14/23.
//

import SwiftUI
import Firebase

@main
struct FocusEurekaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
}
