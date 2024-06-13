//
//  DataKitTests.swift
//  DataKitTests
//
//  Created by Warrd Adlani on 11/06/2024.
//

import XCTest
import Combine

@testable import DataKit

// CRUD Tests
final class DataKitTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    private var queue = DispatchQueue(label: "async-queue")
    
    // Save note
    func test_Given_Note_Saved_Then_Read_Note_Exists() {
        
        let content = "Test note content"
        let title = "Test note title"
        
        let dataService = DataService(storageTech: .coreData)
        let expectation = expectation(description: "save-note-expectation")
        dataService.saveNote(with: title, and: content)
            .sink { result in
                
            } receiveValue: { note in
                XCTAssertNotNil(note.id)
                XCTAssertEqual(note.title!, title)
                XCTAssertEqual(note.content!, content)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 4)
    }
    
    // Update note
    func test_Given_Note_Exists_Then_Update_Note() {
        let content = "Test note content"
        let title = "Test note title"
        let content2 = "Test note content updated"
        let title2 = "Test note title updated"
        var note: Note? = nil
        
        let dataService = DataService(storageTech: .coreData)
        let expectation = expectation(description: "update-note-expectation")
        
        dataService.saveNote(with: title, and: content)
            .sink { _ in } receiveValue: { savedNote in
                note = savedNote
            }
            .store(in: &cancellables)
        
        dataService.updateNote(with: note!.id!, title: title2, and: content2)
            .sink { result in
                
            } receiveValue: { saved in
                XCTAssertTrue(saved)
                XCTAssertEqual(note!.title!, title2)
                XCTAssertEqual(note!.content!, content2)
                
                XCTAssertNotEqual(note!.title!, title2 + "X")
                XCTAssertNotEqual(note!.content!, content2 + "Y")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 4)
    }
    
    // Delete note
    func test_Given_User_Deletes_Note_Then_Cofirm_Deletion() {
        let content = "Test note content"
        let title = "Test note title"
        var note: Note? = nil
        
        let dataService = DataService(storageTech: .coreData)
        let expectation = expectation(description: "delete-note-expectation")
        
        dataService.saveNote(with: title, and: content)
            .sink { _ in } receiveValue: { savedNote in
                note = savedNote
                XCTAssertNotNil(note)
            }
            .store(in: &cancellables)
        
        dataService.removeNote(with: note!.id!)
            .sink { _ in } receiveValue: { success in
                XCTAssertTrue(success)
            }
            .store(in: &cancellables)
        
        queue.asyncAfter(deadline: .now() + 2) {
            XCTAssertNil(note?.id)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4)
    }
    
    func test_Given_User_Has_Existing_Note_Then_Read_Note() {
        let content = "Test note content"
        let title = "Test note title"
        var note: Note? = nil
        
        let dataService = DataService(storageTech: .coreData)
        let expectation = expectation(description: "delete-note-expectation")
        
        dataService.saveNote(with: title, and: content)
            .sink { _ in } receiveValue: { savedNote in
                note = savedNote
                XCTAssertNotNil(note)
            }
            .store(in: &cancellables)
        
        queue.asyncAfter(deadline: .now() + 2) {
            let existingNote = dataService.fetchNote(with: note!.id!)
            XCTAssertNotNil(existingNote)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4)
    }
    
    func test_Given_Two_Notes_Added_Then_Two_Notes_Should_Exist_In_List() {
        let content1 = "Test note content 1"
        let title1 = "Test note title 1"
        
        let content2 = "Test note content 2"
        let title2 = "Test note title 2"
        
        var note1: Note? = nil
        var note2: Note? = nil
        
        var notes: [Note] = []
        
        let dataService = DataService(storageTech: .coreData)
        let expectation = expectation(description: "fetch-results-note-expectation")
        dataService.deleteAll()
        dataService.notesPublisher.sink { storedNotes in
            notes = storedNotes
        }
        .store(in: &cancellables)
        
        dataService.saveNote(with: title1, and: content1)
            .sink { _ in } receiveValue: { savedNote in
                note1 = savedNote
            }
            .store(in: &cancellables)
        
        dataService.saveNote(with: title2, and: content2)
            .sink { _ in } receiveValue: { savedNote in
                note2 = savedNote
            }
            .store(in: &cancellables)
        
        queue.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(notes.count, 2)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4)
    }
}
