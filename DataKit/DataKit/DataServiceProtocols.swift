//
//  DataServiceProtocols.swift
//  DataKit
//
//  Created by Warrd Adlani on 12/06/2024.
//

import Foundation
import Combine

public protocol StoreService {
    var notesPublisher: AnyPublisher<[Note], Never> { get }
    func saveNote(with title: String, and content: String) -> Future<Note, Error>
    func removeNote(with id: UUID) -> Future<Bool, Error>
    func fetchNote(with id: UUID)-> Note?
    func updateNote(with id: UUID, title: String, and content: String) -> Future<Bool, Error>
    func fetchAllNotes() -> Future<[Note], Error>
    func deleteAll()
}

public protocol DataServiceProtocol: StoreService {
    init(storageTech: StorageType)
}
