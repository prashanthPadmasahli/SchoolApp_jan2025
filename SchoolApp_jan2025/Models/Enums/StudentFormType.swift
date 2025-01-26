//
//  StudentFormType.swift
//  SchoolApp_jan2025
//
//  Created by mac on 24/01/25.
//

import Foundation
enum StudentFormType {
    case addNew
    case update
    //case existing
    
    var formTitle: String {
        switch self {
        case .addNew: "Add Student"
        case .update: "Edit Student"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .addNew: "Add"
        case .update: "Update"
        }
    }
}
