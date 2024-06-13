//
//  NotesListViewProtocols.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import SwiftUI
import DataKit

protocol NotesListViewModelProtocol: ViewModelling {
    // Properties
    var notes: [Note] { get set }
    var dataService: DataService { get }
    
    init(coordinator: Coordinator, dataService: DataService) 

    // View methods
    func onAppear()
    
    // Note methods
    func delete(note: Note)
    func show(note: Note?) 
    func newNote()
}

protocol NotesListViewProtocol: View {}
