//
//  TestAppApp.swift
//  TestApp
//
    //  Created by Daniel Jermaine on 06/09/2025.
//

import SwiftUI
import FirebaseCore
@main
struct TestAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            PlaylistView()
        }
    }
}
