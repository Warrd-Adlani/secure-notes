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

public protocol DataServiceProtocol {
    init()
    
    func saveNote(with title: String, and content: String)
    func removeNote(with id: UUID)
    func updateNote(with id: UUID)
    func undoNote(with id: UUID)
}

public final class DataService: DataServiceProtocol {
    
    private lazy var dataController = DataController()
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    
    public required init() {
        dataController.loadPersistantStores()
    }
    
    public func saveNote(with title: String, and content: String) {
        
    }
    
    public func removeNote(with id: UUID) {
            
    }
    
    public func updateNote(with id: UUID) {
            
    }
    
    public func undoNote(with id: UUID) {
            
    }
    
//    public func getNotes() -> AnyPublisher<[Note]> {
//        
//    }
}
