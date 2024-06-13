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
    // Properties
    var notes: [Note] { get set }
    var dataService: DataService { get }
    
    // View methods
    func onAppear()
    
    // Note methods
    func deleteNote(_ note: Note)
}

public protocol NotesListViewProtocol: View {}
