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
                            NoteListViewCell(title: note.title ?? "", timestamp: note.timestamp ?? Date())
                            .onTapGesture {
                                viewModel.show(note: note)
                            }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.map { viewModel.notes[$0] }.forEach { note in
                            viewModel.delete(note: note)
                        }
                    })
                }
            }
            .padding(.top, 10)
            .navigationTitle("Your notes")
            .toolbar(content: {
                Button {
                    viewModel.show(note: nil)
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
    NotesListView(viewModel: NotesListViewModel(coordinator: AppCoordinator(), dataService: DataService(storageTech: .coreData)))
}
