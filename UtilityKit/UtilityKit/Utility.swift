//
//  Utility.swift
//  Utility
//
//  Created by Warrd Adlani on 11/06/2024.
//

import Foundation

public let isRunningUITests = ProcessInfo.processInfo.arguments.contains("isRunningUITests")
public let isRunningUnitTests: Bool = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
public var isDebug: Bool {
    #if DEBUG
    print("Debugging enabled")
    return true
    #else
    print("Debugging disabled")
    return false
    #endif
}
