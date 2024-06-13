//
//  AppCoordinator.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 13/06/2024.
//

import Foundation
import SwiftUI
import DataKit

class AppCoordinator: AppCoordinatorProtocol {
    @Published var currentView: AppView = .splash
    private var dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    enum AppView {
        case splash
        case signIn
        case notesList
        case note(note: Note)
    }
    
    func showSplash() {
        currentView = .splash
    }
    
    func showSignIn() {
        currentView = .signIn
    }
    
    func showNotesList() {
        currentView = .notesList
    }
    
    func showNote(note: Note) {
        currentView = .note(note: note)
    }
}
