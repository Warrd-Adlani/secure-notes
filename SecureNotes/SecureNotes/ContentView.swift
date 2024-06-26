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
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        NavigationStack {
            VStack {
                switch coordinator.currentView {
                case .splash:
                    SplashScreenView()
                case .signIn:
                    SignInView(viewModel: SignInViewModel(coordinator: coordinator))
                case .notesList:
                    NotesListView(
                        viewModel: NotesListViewModel(
                            coordinator: coordinator,
                            dataService: DataService(storageTech: .coreData))
                    )
                case .note(let note):
                    NoteView(viewModel:
                                NoteViewModel(
                                    note: note,
                                    coordinator: coordinator,
                                    dataService: DataService(storageTech: .coreData))
                    )
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    coordinator.showSignIn()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppCoordinator())
}
