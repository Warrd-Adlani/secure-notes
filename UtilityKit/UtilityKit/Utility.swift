//
//  Utility.swift
//  Utility
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation

public final class Utility {
    public static var shared = Utility()
    
    private init() {}
    
    public var isDebug: Bool {
        #if DEBUG
        print("Debugging enabled")
        return true
        #else
        print("Debugging disabled")
        return false
        #endif
    }
}
