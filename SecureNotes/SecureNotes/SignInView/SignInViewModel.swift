//
//  SignInViewModel.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 13/06/2024.
//

import Foundation

protocol SignInViewModelProtocol: ViewModelling {
    init(coordinator: Coordinator)
    func signIn()
}

class SignInViewModel<Coordinator: AppCoordinatorProtocol>: SignInViewModelProtocol {
    private let coordinator: Coordinator
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func signIn() {
        coordinator.showNotesList()
    }
}
