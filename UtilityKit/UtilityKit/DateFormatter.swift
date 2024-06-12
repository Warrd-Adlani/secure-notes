//
//  DateFormatter.swift
//  UtilityKit
//
//  Created by Warrd Adlani on 12/06/2024.
//

import Foundation

public let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
