//
//  DataService.swift
//  Data
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import Combine
import SwiftUI

public final class DataService: DataServiceProtocol {
    private var storeService: StoreService?
    
    public required init(storageTech: StorageType) {
        switch storageTech {
        case .coreData:
            self.storeService = CoreDataService.shared
        case .swiftData:
            break // TODO
        case .realm:
            break // TODO
        }
    }
    
    public func saveNote(with title: String, and content: String) {
        storeService?.saveNote(with: title, and: content)
    }
    
    public func removeNote(with id: UUID) {
        storeService?.removeNote(with: id)
    }
    
    public func updateNote(with id: UUID, title: String, and content: String) {
        storeService?.updateNote(with: id, title: title, and: content)
    }
    
    public func fetchNote(with id: UUID) -> Note? {
        storeService?.fetchNote(with: id)
    }
    
    public func fetchAllNotes() {
        storeService?.fetchAllNotes()
    }
}
