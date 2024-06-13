//
//  NotesListViewModel.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Combine
import Foundation
import DataKit
import UtilityKit

final class NotesListViewModel: NotesListViewModelProtocol {
    @Published var notes: [Note] = []
    
    private (set) var dataService: DataService
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: DataService = DataService(storageTech: .coreData)) {
        self.dataService = dataService
    }
    
    func onAppear() {}
    
    func fetchNotes() {
        dataService.fetchAllNotes()
            .receive(on: DispatchQueue.main)
            .sink { result in
            switch result {
            case .finished: break
            case .failure(_): break
            }
        } receiveValue: { [self] notes in
            self.notes = notes
            log(notes)
        }
        .store(in: &cancellables)
    }
    
    func deleteNote(_ note: Note) {
        guard
            let id = note.id
        else {
            fatalError("ID missing in note")
        }
        
        dataService.removeNote(with: id)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { success in
                // TODO: Show alert
                log(success)
            }
            .store(in: &cancellables)
    }
}

extension NotesListViewModel {
    static var mock: Self {
        return Self(dataService: DataService(storageTech: .coreData))
    }
}
