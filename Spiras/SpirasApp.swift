//
//  SpirasApp.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import SwiftUI

@main
struct SpirasApp: App {
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
