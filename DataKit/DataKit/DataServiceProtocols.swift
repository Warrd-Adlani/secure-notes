//
//  DataServiceProtocols.swift
//  DataKit
//
//  Created by Warrd Adlani on 12/06/2024.
//

import Foundation
import Combine

public protocol StoreService {
    func saveNote(with title: String, and content: String) -> Future<Bool, Error>
    func removeNote(with id: UUID) -> Future<Bool, Error>
    func fetchNote(with id: UUID)-> Note?
    func updateNote(with id: UUID, title: String, and content: String) -> Future<Bool, Error>
    func fetchAllNotes() -> Future<[Note], Error>
}

public protocol DataServiceProtocol: StoreService {
    init(storageTech: StorageType)
}
