//
//  NotesListViewProtocols.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import DomainKit

public protocol NotesListViewModelProtocol: ObservableObject {
    func fetchNotes()
}

public protocol NotesListViewProtocol: View {}
