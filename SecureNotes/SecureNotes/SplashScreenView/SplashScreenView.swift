//
//  SplashScreenView.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 12/06/2024.
//

import SwiftUI
import PresentationKit

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            AppLogoView()
        }
        .background(.black)
        .ignoresSafeArea()
        .transition(.opacity)
        .animation(.easeInOut, value: 1.5)
    }
}

#Preview {
    SplashScreenView()
}
