//
//  NotesListViewModel.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import DomainKit
import DataKit
import SwiftUI

class NotesListViewModel: NotesListViewModelProtocol {
    let dataService = DataService(storageTech: .coreData)
    
    func fetchNotes() {
        // TODO
        print("fetching")
        dataService.saveNote(with: "Title ABC", and: "Some random content")
    }
}
