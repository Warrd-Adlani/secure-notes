//
//  NotesListViewProtocols.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import SwiftUI

public protocol NotesListViewModelProtocol: ObservableObject {
    func fetchNotes()
    func saveNote()
}

public protocol NotesListViewProtocol: View {}
