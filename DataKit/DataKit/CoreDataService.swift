import Foundation
import CoreData
import DomainKit

internal final class CoreDataService: StoreService {
    static var shared = CoreDataService() // Prevents multiple creations of the store
    private lazy var container: NSPersistentContainer = {
        let modelName = "SecureNotes"
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: modelName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }

        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let container = NSPersistentContainer(name: modelName, managedObjectModel: mom)
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private var managedObjectContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {
        loadPersistentStores()
    }
    
    private func loadPersistentStores() {
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            print("loadPersistentStores loaded")
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
            print("Saved successfully")
        } catch {
            print("Failed to save note: \(error)")
        }
    }
    
    func removeNote(with id: UUID) {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let notes = try managedObjectContext.fetch(fetchRequest)
            for note in notes {
                managedObjectContext.delete(note)
            }
            try managedObjectContext.save()
            print("Removed successfully")
        } catch {
            print("Failed to remove note: \(error)")
        }
    }
    
    func fetchNote(with id: UUID) -> Note? {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let notes = try managedObjectContext.fetch(fetchRequest)
            return notes.first
        } catch {
            print("Failed to fetch note: \(error)")
            return nil
        }
    }
    
    func updateNote(with id: UUID, title: String, and content: String) {
        if let note = fetchNote(with: id) {
            note.title = title
            note.content = content
            note.timestamp = Date()
            
            do {
                try managedObjectContext.save()
                print("Updated successfully")
            } catch {
                print("Failed to update note: \(error)")
            }
        }
    }
    
    func fetchAllNotes() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
//            return try managedObjectContext.fetch(fetchRequest)
            let notes = try managedObjectContext.fetch(fetchRequest)
            print(notes)
            for note in notes {
                print(note.title)
            }

        } catch {
            print("Failed to fetch notes: \(error)")
//            return []
        }
    }
}
