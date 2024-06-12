//
//  NotesListView.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import SwiftUI

struct NotesListView<ViewModel: NotesListViewModelProtocol>: NotesListViewProtocol {
    private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                List(0...10, id: \.self) { _ in
                    Text("Notes view")
                        .onTapGesture {
                            self.viewModel.fetchNotes()
                        }
                }
                Button {
                    viewModel.fetchNotes()
                } label: {
                    Text("Load notes")
                }
            }
        }
        .navigationTitle(Text("Notes"))
    }
}

#Preview {
    NotesListView(viewModel: NotesListViewModel())
}
