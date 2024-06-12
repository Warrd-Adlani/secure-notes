//
//  NoteListViewCell.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 12/06/2024.
//

import SwiftUI
import DomainKit

struct NoteListViewCell: View {
    private let title: String
    private let timestamp: Date
    
    init(title: String, timestamp: Date) {
        self.title = title
        self.timestamp = timestamp
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
            Text("\(timestamp)")
                .font(.caption2)
        }
    }
}

#Preview {
    NoteListViewCell(title: "Mock Title", timestamp: Date())
}
