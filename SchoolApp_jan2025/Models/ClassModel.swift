//
//  ClassModel.swift
//  SchoolApp_jan2025
//
//  Created by mac on 24/01/25.
//

import Foundation

struct ClassModel: Identifiable, Codable {
    let id = UUID()
    let name: String
    let teacher: String
    var students: [StudentModel] = []
}
