//
//  SpirasApp.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import SwiftUI

@main
struct SpirasApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject private var data = RoutineData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RoutinesMenuView(routines: $data.routines) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Change navigation bar
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(Color("7-Purple"))
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
               
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        // Request notification authorizations
        let notifications = UNUserNotificationCenter.current()
        notifications.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Authorization granted")
            } else {
                print("Authorization error")
            }
        }
        
        return true
    }
}
