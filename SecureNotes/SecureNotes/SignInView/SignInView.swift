//
//  SignInView.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 12/06/2024.
//

import SwiftUI
import PresentationKit

protocol SignInViewProtocol: View {}

struct SignInView: SignInViewProtocol {
    @EnvironmentObject var appState: AppState
    @State private var isAuthenticated = false {
        didSet {
            appState.isAuthorised = isAuthenticated
        }
    }
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            AppLogoView(.black)
            Spacer()
            Button {                
                AuthenticationServices.shared.authenticate()
            } label: {
                Text("Tap to sign in with Face ID")
            }
            .buttonStyle(.bordered)
            .tint(.mint)
            Spacer()
        }
        .padding()
        .task {
            AuthenticationServices.shared.callback = { [self] result in
                switch result {
                case .success(let isAuthenticated):
                    self.isAuthenticated = isAuthenticated
                case .failure(_):
                    self.showAlert = true
                }
            }
        }
        .alert("Could not authenticate you", isPresented: $showAlert) {
            Button("OK") { }
        }
    }
}

#Preview {
    SignInView()
}
