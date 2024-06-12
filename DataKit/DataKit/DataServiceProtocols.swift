//
//  DataServiceProtocols.swift
//  DataKit
//
//  Created by Warrd Adlani on 12/06/2024.
//

import Foundation

public protocol StoreService {
    func saveNote(with title: String, and content: String)
    func removeNote(with id: UUID)
    func fetchNote(with id: UUID) -> Note?
    func updateNote(with id: UUID, title: String, and content: String)
    func fetchAllNotes()
}

public protocol DataServiceProtocol: StoreService {
    init(storageTech: StorageType)
}
