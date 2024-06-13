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
    
    func showSplash() {
        currentView = .splash
    }
    
    func showSignIn() {
        currentView = .signIn
    }
    
    func showNotesList() {
        currentView = .notesList
    }
    
    func show(note: Note?) {
        currentView = .note(note: note)
    }
    
    func newNote() {
        currentView = .note(note: nil)
    }
}
