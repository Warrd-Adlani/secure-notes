//
//  DataService.swift
//  Data
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation

public protocol DataServiceProtocol {
    init()
    
    func saveNote(with title: String, and content: String)
    func removeNote(with id: UUID)
    func updateNote(with id: UUID)
    func undoNote(with id: UUID)
}

public final class DataService: DataServiceProtocol {
    
    public func saveNote(with title: String, and content: String) {
            
    }
    
    public func removeNote(with id: UUID) {
            
    }
    
    public func updateNote(with id: UUID) {
            
    }
    
    public func undoNote(with id: UUID) {
            
    }
    
    public required init(){}
}
