//
//  DataController.swift
//  DataKit
//
//  Created by Warrd Adlani on 12/06/2024.
//

import CoreData
import Foundation
import UtilityKit
import DomainKit

internal protocol DataControllerProtocol {
    func saveNote(with title: String, and content: String)
    func removeNote(with id: UUID)
    func updateNote(with id: UUID)
    func readNote(with id: UUID)
}

internal final class DataController: DataControllerProtocol {
    private let container = NSPersistentContainer(name: "SecureNotes")
    private var managedObjectContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {}
    
    func loadPersistantStores() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveNote(with title: String, and content: String) {
        let note = Note(context: managedObjectContext)
        note.id = UUID()
        note.title = title
        note.content = content
        note.timestamp = Date()
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func removeNote(with id: UUID) {
    
    }
    
    func readNote(with id: UUID) {
        
    }
    
    func updateNote(with id: UUID) {
        
    }
}
