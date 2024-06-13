//
//  NotesViewProtocols.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import DataKit
import SwiftUI

protocol NoteViewModelProtocol: ViewModelling {
    
    // Variables
    var noteTitle: String { get set }
    var noteContent: String { get set }
    var deleteEnabled: Bool { get set }
    var toastMessage: String { get set }
    var showToast: Bool { get set }
    
    init(note: Note?, coordinator: Coordinator, dataService: DataServiceProtocol)
    
    // View methods
    func onAppear()
    func close()
    
    // Note methods
    func saveNote()
    func updateNote()
    func deleteNote()
}

protocol NoteViewProtocol: View {}
