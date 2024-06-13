import Foundation
import CoreData
import Combine
import DomainKit
import UtilityKit

internal final class CoreDataService: NSObject, StoreService {
    static var shared = CoreDataService() // Prevents multiple creations of the store
    private let modelName = "SecureNotes"

    private lazy var container: NSPersistentContainer = {
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
    
    private override init() {
        super.init()
        loadPersistentStores()
        configureFetchedResultsController()
    }
    
    private func loadPersistentStores() {
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            print("loadPersistentStores loaded")
        }
    }
    
    private var fetchedResultsController: NSFetchedResultsController<Note>?

    private func configureFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Note.timestamp, ascending: false)]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        fetchedResultsController?.delegate = self
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Failed to fetch notes: \(error)")
        }
    }
    
    // Publish updates to the list of notes
    private var notesSubject = PassthroughSubject<[Note], Never>()
    public var notesPublisher: AnyPublisher<[Note], Never> {
        notesSubject.eraseToAnyPublisher()
    }
    
    func saveNote(with title: String, and content: String) -> Future<Note, Error> {
        return Future { [self] promise in
            let note = Note(context: managedObjectContext)
            let id = UUID()
            note.id = id
            note.title = title
            note.content = content
            note.timestamp = Date()
            
            do {
                try managedObjectContext.save()
                log("Saved successfully")
                promise(.success(note))
            } catch {
                log("Failed to save note: \(error)")
                promise(.failure(error))
            }
        }
    }
    
    func removeNote(with id: UUID) -> Future<Bool, any Error> {
        return Future { [self] promise in
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                let notes = try managedObjectContext.fetch(fetchRequest)
                for note in notes {
                    managedObjectContext.delete(note)
                }
                try managedObjectContext.save()
                log("Removed successfully")
                promise(.success(true))
            } catch {
                log("Failed to remove note: \(error)")
                promise(.failure(error))
            }
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
    
    func updateNote(with id: UUID, title: String, and content: String) -> Future<Bool, any Error> {
        return Future { [self] promise in
            if let note = fetchNote(with: id) {
                note.title = title
                note.content = content
                note.timestamp = Date()
                
                do {
                    try managedObjectContext.save()
                    promise(.success(true))
                    log("Updated successfully")
                } catch {
                    log("Failed to update note: \(error)")
                    promise(.failure(error))
                }
            }
        }
    }
    
    func fetchAllNotes() -> Future<[Note], Error> {
        return Future { [self] promise in
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            do {
                let notes = try managedObjectContext.fetch(fetchRequest)
                promise(.success(notes))
            } catch {
                log("Failed to fetch notes: \(error)")
                promise(.failure(error))
            }
        }
    }
}

extension CoreDataService: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let notes = controller.fetchedObjects as? [Note] else { return }
        notesSubject.send(notes)
    }
}
