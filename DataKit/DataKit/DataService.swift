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
            self.storeService = CoreDataService()
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
    
    public func updateNote(with id: UUID) {
        storeService?.updateNote(with: id)
    }
    
    public func readNote(with id: UUID) {
        storeService?.readNote(with: id)
    }
    
    public func fetchNotes() {
        storeService?.fetchNotes()
    }
}
