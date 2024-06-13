//
//  ViewProtocols.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 13/06/2024.
//

import Foundation

protocol ViewModelling: ObservableObject {
    associatedtype Coordinator: AppCoordinatorProtocol
}
