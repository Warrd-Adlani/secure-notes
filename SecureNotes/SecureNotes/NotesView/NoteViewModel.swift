//
//  NoteViewModel.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import Combine
import DataKit
import DomainKit

enum NoteToastType: String {
    case saved = "Note saved"
    case updated = "Note updated"
}

class NoteViewModel<Coordinator: AppCoordinatorProtocol>: NoteViewModelProtocol {
    @Published var noteTitle: String = "New note"
    @Published var noteContent: String = "Test toast"
    @Published var deleteEnabled: Bool = true
    @Published var showToast: Bool = false
    var toastMessage: String = ""
    
    private let coordinator: Coordinator
    
    private var note: Note?
    
    private let dataService: DataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    required init(note: Note?, coordinator: Coordinator, dataService: DataServiceProtocol) {
        self.note = note
        self.dataService = dataService
        self.coordinator = coordinator
    }
    
    func onAppear() {
        noteTitle = note?.title ?? "New note"
        noteContent = note?.content ?? ""
        deleteEnabled = (note == nil)
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
                    self?.shouldShowToast(for: .saved)
                case .failure(_):
                    break
                }}, receiveValue: { [self] note in
                    self.note = note
                    deleteEnabled = true
                })
            .store(in: &cancellables)
    }
    
    private func shouldShowToast(for type: NoteToastType) {
        showToast = true
        toastMessage = type.rawValue
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.showToast = false
            self?.toastMessage = ""
        }
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
                    self?.shouldShowToast(for: .updated)
                case .failure(_):
                    break
                }}, receiveValue: { _ in})
            .store(in: &cancellables)
    }
    
    func close() {
        coordinator.showNotesList()
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
            .sink(receiveCompletion: { [self] result in
                switch result {
                case .finished:
                    coordinator.showNotesList()
                case .failure(_):
                    break
                }}, receiveValue: { _ in})
            .store(in: &cancellables)
    }
}

extension NoteViewModel {
    static var mock: NoteViewModel {
        return Self(note: nil, coordinator: AppCoordinator() as! Coordinator, dataService: DataService(storageTech: .coreData))
    }
}
