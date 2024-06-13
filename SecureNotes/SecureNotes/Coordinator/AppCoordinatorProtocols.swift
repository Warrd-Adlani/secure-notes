//
//  AppCoordinatorProtocols.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 13/06/2024.
//

import Foundation
import DataKit

enum AppView: Equatable {
    case splash
    case signIn
    case notesList
    case note(note: Note?)
}

protocol AppCoordinatorProtocol: ObservableObject {
    func showSignIn()
    func showNotesList()
    func show(note: Note?)
    func newNote()
}
