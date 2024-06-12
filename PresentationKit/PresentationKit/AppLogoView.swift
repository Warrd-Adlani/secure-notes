//
//  AppLogoView.swift
//  PresentationKit
//
//  Created by Warrd Adlani on 12/06/2024.
//

import SwiftUI

public struct AppLogoView: View {
    private var style: Color
    
    public init(_ style: Color = .white) {
        self.style = style
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "pencil.and.outline")
            Text("Secure Notes")
        }
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .foregroundStyle(style)
    }
}

#Preview {
    AppLogoView()
}
