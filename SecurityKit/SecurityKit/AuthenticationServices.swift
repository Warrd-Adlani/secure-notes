//
//  AuthenticationServices.swift
//  SecureNotes
//
//  Created by Warrd Adlani on 13/06/2024.
//

import Foundation
import LocalAuthentication
import UtilityKit
import Combine

public final class AuthenticationServices {
    public static var shared = AuthenticationServices()
    public var callback: ((Result<Bool, Error>) -> Void)?
    
    private init() {}
    
    public func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your notes"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.callback?(.failure(error))
                    } else {
                        self?.callback?(.success(success))
                    }
                }
            }
        } else {
            log("No biometrics available")
            if let error = error {
                callback?(.failure(error))
            }
        }
    }
}
