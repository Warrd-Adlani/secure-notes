//
//  NoteView.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import SwiftUI

struct NoteView<ViewModel: NoteViewModelProtocol>: NoteViewProtocol {
    
    @ObservedObject var viewModel: ViewModel
    @Environment (\.dismiss) var dismiss

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
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text(viewModel.alert?.alert?.title ?? ""))
        })
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
        .toolbar(content: {
            HStack {
                Button {
                    viewModel.deleteNote()
                } label: {
                    Text("Delete note")
                }
                
                Spacer()
                
                Button {
                    viewModel.saveNote()
                } label: {
                    Text("Save note")
                }
            }
        })
    }
}

#Preview {
    NoteView(viewModel: NoteViewModel.mock)
}
