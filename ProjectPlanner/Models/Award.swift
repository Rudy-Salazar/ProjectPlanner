//
//  Award.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/1/21.
//

import Foundation

struct Award: Decodable, Identifiable {
    var id: String { name }
    let name: String
    let description: String
    let color: String
    let criterion: String
    let value: Int
    let image: String

    static let allAwards = Bundle.main.decode([Award].self, from: "Awards.json")
    static let exameple = allAwards[0]
}
