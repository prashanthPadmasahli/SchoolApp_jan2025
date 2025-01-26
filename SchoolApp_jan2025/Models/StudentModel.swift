//
//  StudentModel.swift
//  SchoolApp_jan2025
//
//  Created by mac on 24/01/25.
//

import Foundation

struct StudentModel: Identifiable, Codable {
    var id = UUID().uuidString
    let firstName: String
    let lastName: String
    let regNo: String
    let gender: Bool
    let age: String
}
