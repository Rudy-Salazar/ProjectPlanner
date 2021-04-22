//
//  AwardTests.swift
//  ProjectPlannerTests
//
//  Created by Rodolfo Salazar on 4/19/21.
//
import CoreData
import XCTest
@testable import ProjectPlanner

class AwardTests: BaseTestCase {
    let awards = Award.allAwards
    
    func testAwardIDMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id , award.name, "Award ID should always match its name.")
        }
    }
    
    func testNewUserNoAwards() {
        for award in awards {
            XCTAssertFalse(dataController.hasEarned(award: award), "New users should have no earned awards.")
        }
    }
    
    func testAddingItems() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]
        
        for (count, value) in values.enumerated() {
            var items = [Item]()
            
            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                items.append(item)
            }
        }
    }
}
