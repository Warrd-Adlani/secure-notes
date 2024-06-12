//
//  NotesListView.swift
//  secure-notes
//
//  Created by Warrd Adlani on 11/06/2024.
//

import SwiftUI

struct NotesListView: NotesListViewProtocol {
    
    var body: some View {
        VStack {
            NavigationStack {
                List(0...10, id: \.self) { _ in
                    Text("Notes view")
                }
            }
        }
        .navigationTitle(Text("Notes"))
    }
}

#Preview {
    NotesListView()
}
