//
//  FHNW_ChartsApp.swift
//  FHNW-Charts
//
//  Created by Ingo Boehme on 09.01.23.
//

import SwiftUI

@main
struct FHNW_ChartsApp: App {
    let appState = AppState()

    var body: some Scene {
        WindowGroup {
            ChartView()
                .environmentObject(appState)
        }
    }
}
