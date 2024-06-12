//
//  Logger.swift
//  UtilityKit
//
//  Created by Warrd Adlani on 12/06/2024.
//

import Foundation

public func log(_ value: Any) {
    if isDebug {
        print(value)
    }
}


