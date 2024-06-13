//
//  UtilityKitTests.swift
//  UtilityKitTests
//
//  Created by Warrd Adlani on 11/06/2024.
//

import XCTest
@testable import UtilityKit

final class UtilityKitTests: XCTestCase {
    
    func test_Given_App_Debug_Then_Return_True() {
        XCTAssertTrue(isDebug)
    }
    
    func test_Given_Tests_Running_Then_Print_State() {        
        XCTAssertTrue(isRunningUnitTests, "Tests are running")
    }

}
