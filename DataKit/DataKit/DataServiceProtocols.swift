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
    func updateNote(with id: UUID)
    func readNote(with id: UUID)
    func fetchNotes()
}

public protocol DataServiceProtocol: StoreService {
    init(storageTech: StorageType)
}
