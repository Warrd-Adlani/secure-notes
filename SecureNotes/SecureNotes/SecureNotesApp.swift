//
//  SecureNotesApp.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import SwiftUI
import DataKit

@main
struct SecureNotesApp: App {

    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
        }
    }
}
