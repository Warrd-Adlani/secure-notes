//
//  ContentView.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import SwiftUI
import CoreData
import DataKit

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            switch appState.screen {
            case .splash:
                SplashScreenView()
            case .signIn:
                SignInView()
            case .notes:
                NotesListView()
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.appState.screen = .signIn
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
