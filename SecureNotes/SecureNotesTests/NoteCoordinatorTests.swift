//
//  NoteCoordinatorTest.swift
//  SecureNotesTests
//
//  Created by Warrd Adlani on 13/06/2024.
//

import XCTest
import Combine
@testable import SecureNotes

final class NoteCoordinatorTest: XCTestCase {
    func test_Given_User_Taps_Notes_Then_Show_Notes() {
        let coordinator = AppCoordinator()
        var cancellables = Set<AnyCancellable>()
        var view: AppView?
        let expectation = expectation(description: "coordinator-view-change-expecation")
        
        coordinator.showNotesList()
        
        coordinator.$currentView.sink { currentView in
            view = currentView
            expectation.fulfill()
        }
        .store(in: &cancellables)
        
        XCTAssertEqual(view, AppView.notesList)
        
        waitForExpectations(timeout: 1)
    }
}
