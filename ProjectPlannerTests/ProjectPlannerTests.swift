//
//  ProjectPlannerTests.swift
//  ProjectPlannerTests
//
//  Created by Rodolfo Salazar on 4/10/21.
//

import CoreData
import XCTest
@testable import ProjectPlanner

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
