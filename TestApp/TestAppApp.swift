//
//  TestAppApp.swift
//  TestApp
//
    //  Created by Daniel Jermaine on 06/09/2025.
//

import SwiftUI
import FirebaseCore
import MusicKit

@main
struct TestAppApp: App {
    
    @State private var musicAuthorizationStatus = MusicAuthorization.Status.notDetermined

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            PlaylistView()
                .onAppear(perform: requestMusicAuthorization)
        }
    }

    private func requestMusicAuthorization() {
        Task {
            let status = await MusicAuthorization.request()
            DispatchQueue.main.async {
                self.musicAuthorizationStatus = status
            }
        }
    }
}
