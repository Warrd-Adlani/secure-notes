//
//  SecureNotesViewModelTests.swift
//  SecureNotesTests
//
//  Created by Warrd Adlani on 13/06/2024.
//

import XCTest
import Combine
import DataKit

@testable import SecureNotes

final class SecureNotesViewModelTests: XCTestCase {

    // Sign In VM tests
    func test_Given_Sign_In_Successful_Then_Show_Notes() {
        var cancellables = Set<AnyCancellable>()
        let coordinator = AppCoordinator()
        let viewModel = SignInViewModel(coordinator: coordinator)
        var view: AppView?
        let expectation = expectation(description: "view-change-expecation")
        
        coordinator.$currentView
            .sink { currentView in
                view = currentView
            }
            .store(in: &cancellables)
        
        viewModel.signIn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(view, AppView.notesList)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }


//    func test_Given_User_Taps_Delete_Then_Delete_Note() {
//        let coordinator = AppCoordinator()
//        let dataService = DataService(storageTech: .coreData)
//        var cancellables = Set<AnyCancellable>()
//        let viewModel = NotesListViewModel(coordinator: coordinator, dataService: dataService)
//        let expectation = expectation(description: "delete-note-expectation")
//        var notes: [Note]?
//        var deleted = false
//        viewModel.onAppear()
//        
//        _ = dataService.saveNote(with: "Mock Title 1", and: "Mock content 1")
//        _ = dataService.saveNote(with: "Mock Title 2", and: "Mock content 2")
//        _ = dataService.notesPublisher.sink { savedNotes in
//            notes = savedNotes
//        }
//        
//        let id = notes?.first?.id
//        print("id", id)
//        _ = dataService.removeNote(with: id).sink(receiveCompletion: { _ in }, receiveValue: { result in
//            deleted = result
//        })
//        
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            XCTAssertTrue(deleted)
//            print(viewModel.notes)
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 3)
//    }
    
    func test_Given_Note_Selected_Then_Show_Note() {
        let coordinator = AppCoordinator()
        let dataService = DataService(storageTech: .coreData)
        var cancellables = Set<AnyCancellable>()
        let viewModel = NotesListViewModel(coordinator: coordinator, dataService: dataService)
        let expectation = expectation(description: "show-note-expectation")
        var notes: [Note]?
        var deleted = false

        dataService.notesPublisher.sink { savedNotes in
            notes = savedNotes
        }
        .store(in: &cancellables)
        
        _ = dataService.saveNote(with: "Mock Title 1", and: "Mock content 1")
        _ = dataService.removeNote(with: notes?.first?.id ?? UUID()).sink(receiveCompletion: { _ in }, receiveValue: { result in
            deleted = result
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(notes)
            XCTAssertTrue(notes!.count == 1)
            XCTAssertTrue(deleted)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
//    func delete(note: Note)
//    func show(note: Note?)
//    func newNote()
}
