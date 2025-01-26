//
//  SchoolModel.swift
//  SchoolApp_jan2025
//
//  Created by mac on 23/01/25.
//

import Foundation

struct SchoolModel: Identifiable, Codable {
    var id = UUID()
    let name: String
    let address: String
    var classes: [ClassModel] = []
}
