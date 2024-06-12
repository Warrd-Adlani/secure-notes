//
//  SignInView.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 12/06/2024.
//

import SwiftUI
import PresentationKit

struct SignInView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            AppLogoView(.black)
            Spacer()
            Button {
                appState.isAuthorised = true
            } label: {
                Text("Tap to sign in with Face ID")
            }
            .buttonStyle(.bordered)
            .tint(.mint)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
