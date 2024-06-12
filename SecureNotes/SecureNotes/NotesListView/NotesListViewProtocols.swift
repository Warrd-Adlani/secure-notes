//
//  NotesListViewProtocols.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import SwiftUI
import DataKit

public protocol NotesListViewModelProtocol: ObservableObject {
    var notes: [Note] { get set }
    
    func fetchNotes()
    func deleteNote(_ note: Note)
}

public protocol NotesListViewProtocol: View {}
