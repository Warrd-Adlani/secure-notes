//
//  AppState.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import Combine
import AuthenticationServices

enum Screens: CaseIterable {
    case splash
    case signIn
    case notes
}

final class AppState: ObservableObject {
    @Published var isAuthorised = false {// TODO: Use FACE-ID
        didSet {
            screen = isAuthorised ? .notes : .signIn
        }
    }
    @Published var showSplashScreen = true
    @Published var screen: Screens = .splash
}
