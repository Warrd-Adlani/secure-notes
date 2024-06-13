//
//  NotesListViewModelTests.swift
//  SecureNotesTests
//
//  Created by Warrd Adlani on 13/06/2024.
//

import XCTest
import Combine
import DataKit

@testable import SecureNotes

final class NotesListViewModelTests: XCTestCase {

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


    func test_Given_User_Taps_Delete_Then_Delete_Note() {
        let coordinator = AppCoordinator()
        let dataService = DataService(storageTech: .coreData)
        let viewModel = NotesListViewModel(coordinator: coordinator, dataService: dataService)
        let expectation = expectation(description: "delete-note-expectation")
        viewModel.onAppear()
        
        _ = dataService.saveNote(with: "Mock Title 1", and: "Mock content 1")
        _ = dataService.saveNote(with: "Mock Title 2", and: "Mock content 2")
        
        viewModel.delete(note: viewModel.notes.first!)
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.notes.count, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }
    
    func test_Given_Note_Selected_Then_Show_Note() {
        let coordinator = AppCoordinator()
        let dataService = DataService(storageTech: .coreData)
        var cancellables = Set<AnyCancellable>()
        let viewModel = NotesListViewModel(coordinator: coordinator, dataService: dataService)
        let expectation = expectation(description: "show-note-expectation")
        let mockTitle = "Mock Title 1"
        let mockContent = "Mock content 1"
        viewModel.onAppear()
        
        _ = dataService.saveNote(with: mockTitle, and: mockContent)
        
        XCTAssertNotNil(viewModel.notes.first)
        XCTAssertEqual(viewModel.notes.first!.title, mockTitle)
        XCTAssertEqual(viewModel.notes.first!.content, mockContent)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }
    
    func test_Given_User_Taps_New_Note_Then_Create_New_Note_View() {
        let coordinator = AppCoordinator()
        let dataService = DataService(storageTech: .coreData)
        let viewModel = NotesListViewModel(coordinator: coordinator, dataService: dataService)
        
        viewModel.newNote()
        
        XCTAssertTrue(coordinator.currentView == .note(note: nil))
    }
}
