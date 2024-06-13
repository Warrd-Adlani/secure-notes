//
//  Security.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 13/06/2024.
//

import Foundation
import LocalAuthentication
import Combine
import UtilityKit

final class AuthenticationServices {
    static var shared = AuthenticationServices()
    var callback: ((Result<Bool, Error>) -> Void)?
    
    @Published private (set) var isUnlocked = false
    
    private init() {}
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your notes"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    if success {
                        self?.isUnlocked = true
                        self?.callback?(.success(true))
                    } else if let error = error {
                        self?.callback?(.failure(error))
                    }
                }
            }
        } else {
            log("No biometrics available")
            callback?(.failure(NSError(domain: "authentication-failure", code: 0001)))
        }
    }
}
