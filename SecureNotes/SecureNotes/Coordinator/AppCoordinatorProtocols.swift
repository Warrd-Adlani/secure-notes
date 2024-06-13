//
//  AppCoordinatorProtocols.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 13/06/2024.
//

import Foundation
import DataKit

protocol AppCoordinatorProtocol: ObservableObject {
    func showSignIn()
    func showNotesList()
    func showNote(note: Note)
}
