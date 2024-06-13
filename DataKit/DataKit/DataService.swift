//
//  DataService.swift
//  Data
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import Combine
import SwiftUI
import DomainKit

public final class DataService: DataServiceProtocol {
    private var storeService: StoreService
    
    public var notesPublisher: AnyPublisher<[Note], Never> {
        return storeService.notesPublisher
    }

    public required init(storageTech: StorageType) {
        switch storageTech {
        case .coreData:
            self.storeService = CoreDataService.shared
        case .swiftData:
            fatalError("Not implemented - this is for illustation purposes only")
            break // TODO
        case .realm:
            fatalError("Not implemented - this is for illustation purposes only")
            break // TODO
        }
    }
    
    public func saveNote(with title: String, and content: String) -> Future<Note, Error> {
        return storeService.saveNote(with: title, and: content)
    }
    
    public func removeNote(with id: UUID) -> Future<Bool, Error> {
        return storeService.removeNote(with: id)
    }
    
    public func updateNote(with id: UUID, title: String, and content: String) -> Future<Bool, Error> {
        return storeService.updateNote(with: id, title: title, and: content)
    }
    
    public func fetchNote(with id: UUID) -> Note? {
        storeService.fetchNote(with: id)
    }
    
    public func fetchAllNotes() -> Future<[Note], Error> {
        return storeService.fetchAllNotes()
    }
    
    public func deleteAll() {
        storeService.deleteAll()
    }
}
