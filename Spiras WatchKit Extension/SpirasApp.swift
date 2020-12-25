//
//  SpirasApp.swift
//  Spiras WatchKit Extension
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import SwiftUI

@main
struct SpirasApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
