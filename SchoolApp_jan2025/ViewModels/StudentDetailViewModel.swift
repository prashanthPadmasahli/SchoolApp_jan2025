//
//  StudentDetailViewModel.swift
//  SchoolApp_jan2025
//
//  Created by mac on 24/01/25.
//

import Foundation

class StudentDetailViewModel: ObservableObject {
    
    let formType: StudentFormType
    let student: StudentModel?
    
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var registerNumber = ""
    @Published var age = ""
    @Published var isMale = true
    
    var detailsEdited: Bool {
        if (firstname != student?.firstName || lastname != student?.lastName || registerNumber != student?.regNo || age != student?.age || isMale != student?.gender) {
            return true
        }
        return false
    }
    
    var disableButton: Bool {
        if formType == .update {
            return !detailsEdited
        } else {
            return firstname.count < 3 || registerNumber.isEmpty
        }
    }
    
    init(formType: StudentFormType, student: StudentModel?) {
        self.formType = formType
        self.student = student
        if let student {
            self.firstname = student.firstName
            self.lastname = student.lastName
            self.registerNumber = student.regNo
            self.age = student.age
            self.isMale = student.gender
        }
    }
}
