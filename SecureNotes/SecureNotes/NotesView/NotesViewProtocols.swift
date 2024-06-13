//
//  NotesViewProtocols.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import DataKit
import SwiftUI

protocol NoteViewModelDelegate {
    func didDeleteNote()
}

protocol NoteViewModelProtocol: ObservableObject {
    
    // Variables
    var noteTitle: String { get set }
    var noteContent: String { get set }
    var alert: NoteViewAlert? { get set }
    var showAlert: Bool { get set }
    var delegate: NoteViewModelDelegate? { get set }
    var deleteEnabled: Bool { get set }
    
    init(note: Note?, dataService: DataServiceProtocol)
    
    // View methods
    func onAppear()
    func set(delegate: NoteViewModelDelegate)
    
    // Note methods
    func saveNote()
    func updateNote()
    func deleteNote()
}

protocol NoteViewProtocol: View {}
