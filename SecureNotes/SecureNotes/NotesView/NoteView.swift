//
//  NoteView.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import SwiftUI
import DataKit

struct NoteView<ViewModel: NoteViewModelProtocol>: NoteViewProtocol {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Group {
                TextField(text: $viewModel.noteTitle) {
                    Text("")
                }
                
                TextEditor(text: $viewModel.noteContent)
                    .lineSpacing(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.1), lineWidth: 0.5)
                    )
            }
            .autocapitalization(.words)
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
        }
        .padding()
    }
}

#Preview {
    NoteView(viewModel: NoteViewModel(dataService: DataService()))
}
