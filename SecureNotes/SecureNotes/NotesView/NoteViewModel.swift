//
//  NoteViewModel.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import Combine
import DataKit

struct AlertItem {
    let title: String
    let body: String
}

enum NoteViewAlert {
    case saved
    case updated
    
    var alert: AlertItem? {
        switch self {
        case .saved:
            return AlertItem(title: "Saved", body: "")
        case .updated:
            return AlertItem(title: "Updated", body: "")
        }
    }
}

class NoteViewModel: NoteViewModelProtocol {
    @Published var noteTitle: String = "New note"
    @Published var noteContent: String = ""
    @Published var alert: NoteViewAlert? {
        didSet {
            showAlert = true
        }
    }
    @Published var showAlert = false
    
    private var note: Note?
    
    private let dataService: DataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    required init(note: Note?, dataService: DataServiceProtocol) {
        self.note = note
        self.dataService = dataService
    }
    
    func onAppear() {
        noteTitle = note?.title ?? "New note"
        noteContent = note?.content ?? ""
    }
    
    func saveNote() {
        guard
            note == nil
        else {
            updateNote()
            return
        }
        
        dataService
            .saveNote(with: noteTitle, and: noteContent)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    self?.alert = .saved
                case .failure(_):
                    break
                }}, receiveValue: { [self] note in
                    self.note = note
                })
            .store(in: &cancellables)
    }
    
    func updateNote() {
        guard
            let id = note?.id
        else {
            return
        }
        
        dataService
            .updateNote(with: id, title: noteTitle, and: noteContent)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    self?.alert = .updated
                case .failure(_):
                    break
                }}, receiveValue: { _ in})
            .store(in: &cancellables)
    }
    
    func deleteNote() {
        guard
            let id = note?.id
        else {
            return
        }
        dataService
            .removeNote(with: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(_):
                    break
                }}, receiveValue: { _ in})
            .store(in: &cancellables)
    }
    func readNote(for id: String) {}
}

extension NoteViewModel {
    static var mock: NoteViewModel {
        return Self(note: nil, dataService: DataService(storageTech: .coreData))
    }
}
