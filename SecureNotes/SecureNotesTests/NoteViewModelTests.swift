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
    
    func test_Given_Old_Note_And_User_Saves_Then_Update_Note() {
        var cancellables = Set<AnyCancellable>()
        let coordinator = AppCoordinator()
        let dataService = DataService(storageTech: .coreData)
        let viewModel = NoteViewModel(note: nil, coordinator: coordinator, dataService: dataService)
        let expectation = expectation(description: "update-expectation")
        
        let title = "Test title 1"
        let content = "Test title 2"
        viewModel.onAppear()
        viewModel.noteTitle = title
        viewModel.noteContent = content

        viewModel.saveNote()

        var note: Note?
        
        dataService.notesPublisher.sink { notes in
            note = notes.first
        }.store(in: &cancellables)
        
        let newTitle = "New title"
        let newContent = "New content"
        viewModel.noteTitle = newTitle
        viewModel.noteContent = newContent
        
        viewModel.saveNote()
        
        expectationQueue.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(note?.title, newTitle)
            XCTAssertEqual(note?.content, newContent)

            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }
}
