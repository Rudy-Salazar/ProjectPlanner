//
//  AssetTest.swift
//  ProjectPlannerTests
//
//  Created by Rodolfo Salazar on 4/10/21.
//

import XCTest
@testable import ProjectPlanner

class AssetTest: XCTestCase {
    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from asset catalog.")
        }
    }
    
    func testJSONLoadCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load awards from JSON")
    }
}
