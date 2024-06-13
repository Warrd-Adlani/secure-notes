//
//  NotesListView.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import SwiftUI
import DataKit

struct NotesListView<ViewModel: NotesListViewModelProtocol>: NotesListViewProtocol {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.notes) { note in
                        NavigationLink(destination: NoteView(viewModel: NoteViewModel(note: note, dataService: DataService(storageTech: .coreData)))) {
                            NoteListViewCell(title: note.title ?? "", timestamp: note.timestamp ?? Date())
                        }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.map { viewModel.notes[$0] }.forEach { note in
                            viewModel.deleteNote(note)
                        }
                    })
                }
            }
            .padding(.top, 10)
            .navigationTitle("Your notes")
            .toolbar(content: {
                NavigationLink(destination: NoteView(viewModel: NoteViewModel(note: nil, dataService: DataService(storageTech: .coreData)))) {
                    Text("New note")
                }
                NavigationLink {
                    NoteView(viewModel: NoteViewModel(note: nil, dataService: DataService(storageTech: .coreData)))
                } label: {
                    Text("New note")
                }
            })
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    NotesListView(viewModel: NotesListViewModel.mock)
}
