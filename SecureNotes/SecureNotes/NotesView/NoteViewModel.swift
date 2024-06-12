//
//  NoteViewModel.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import DataKit

class NoteViewModel: NoteViewModelProtocol {
    @Published var noteTitle: String = "New note"
    @Published var noteContent: String = ""

    private let dataService: DataServiceProtocol
    
    required init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    func saveNote(with title: String, and body: String) {}
    func updateNote(for id: String) {}
    func removeNote(for id: String) {}
    func readNote(for id: String) {}
}
