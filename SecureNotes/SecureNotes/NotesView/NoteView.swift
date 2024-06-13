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
        ZStack {
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
            .ignoresSafeArea()
            .padding()
            
            if viewModel.showToast {
                noteToastView()
                    .ignoresSafeArea()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Confirm Deletion"),
                  message: Text("Are you sure you want to delete this note?"),
                  primaryButton: .destructive(Text("Delete")) {
                viewModel.deleteNote(showWarning: false)
            },
                  secondaryButton: .cancel())
        }
        .toolbar(content: {
            noteToolBarView()
        })
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    fileprivate func noteToolBarView() -> HStack<TupleView<(Button<Text>, Spacer, some View, Spacer, Button<Text>)>> {
        return HStack {
            Button {
                viewModel.close()
            } label: {
                Text("Close")
            }
            
            Spacer()
            
            Button {
                viewModel.deleteNote(showWarning: true)
            } label: {
                Text("Delete note")
            }
            .disabled(viewModel.deleteEnabled)
            
            Spacer()
            
            Button {
                viewModel.saveNote()
            } label: {
                Text("Save note")
            }
        }
    }
    
    
    fileprivate func noteToastView() -> VStack<TupleView<(Spacer, some View)>> {
        return VStack {
            Spacer()
            VStack {
                Text(viewModel.toastMessage)
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(.mint.opacity(0.3))
            .onTapGesture {
                viewModel.showToast.toggle()
            }
            .transition(.move(edge: .bottom))
        }
    }
}

#Preview {
    NoteView(viewModel: NoteViewModel(note: nil, coordinator: AppCoordinator(), dataService: DataService(storageTech: .coreData)))
}
