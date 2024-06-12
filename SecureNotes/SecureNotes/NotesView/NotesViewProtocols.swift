//
//  NotesViewProtocols.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import DataKit
import SwiftUI

protocol NoteViewModelProtocol: ObservableObject {
    
    // Variables
    var noteTitle: String { get set }
    var noteContent: String { get set }
    var alert: NoteViewAlert? { get set }
    var showAlert: Bool { get set }
    
    init(note: Note?, dataService: DataServiceProtocol)
    
    // View methods
    func onAppear()
    
    // Note methods
    func saveNote()
    func updateNote()
    func deleteNote()
}

protocol NoteViewProtocol: View {}
