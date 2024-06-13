//
//  NoteViewModelTests.swift
//  SecureNotesTests
//
//  Created by Warrd Adlani on 13/06/2024.
//

import XCTest
import Combine
import DataKit

@testable import SecureNotes

final class NoteViewModelTests: XCTestCase {


/*
 func saveNote()
 func updateNote()
 func deleteNote(showWarning: Bool)
 */
    let expectationQueue = DispatchQueue(label: "expectation-queue", attributes: .concurrent)
    
    func test_When_User_Taps_Save_Then_Save_Note() {
        var cancellables = Set<AnyCancellable>()
        let coordinator = AppCoordinator()
        let dataService = DataService(storageTech: .coreData)
        let viewModel = NoteViewModel(note: nil, coordinator: coordinator, dataService: dataService)
        let expectation = expectation(description: "save-expectation")
        
        let title = "Test title 1"
        let content = "Test title 2"
        viewModel.onAppear()
        viewModel.noteTitle = title
        viewModel.noteContent = content
        
        var note: Note?
        
        dataService.notesPublisher.sink { notes in
            note = notes.first
        }.store(in: &cancellables)
        
        viewModel.saveNote()
        
        expectationQueue.asyncAfter(deadline: .now() + 3) {
            XCTAssertEqual(note?.title, title)
            XCTAssertEqual(note?.content, content)

            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4)
    }
}
