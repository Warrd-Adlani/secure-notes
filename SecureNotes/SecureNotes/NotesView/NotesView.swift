//
//  NotesView.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import SwiftUI
import DataKit

struct NotesView<ViewModel: NoteViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Notes screen")
    }
}

#Preview {
    NotesView(viewModel: NotesViewModel(dataService: DataService()))
}
