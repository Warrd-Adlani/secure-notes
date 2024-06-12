//
//  CoreDataService.swift
//  DataKit
//
//  Created by Warrd Adlani on 12/06/2024.
//

import CoreData
import Foundation
import UtilityKit
import DomainKit

internal final class CoreDataService: StoreService {
    private lazy var container: NSPersistentContainer = {
        let modelName = "SecureNotes"
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: modelName, withExtension:"momd") else {
                fatalError("Error loading model from bundle")
        }

        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        return NSPersistentContainer(name: modelName, managedObjectModel: mom)
    }()
    
    private var managedObjectContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() { loadPersistantStores() }
    
    func loadPersistantStores() {
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            print("loadPersistantStores loaded")
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
            print("saved")
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
    
    func fetchNotes() {
        
    }
}
