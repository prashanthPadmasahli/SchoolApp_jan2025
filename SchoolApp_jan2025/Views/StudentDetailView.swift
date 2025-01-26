//
//  StudentDetailView.swift
//  SchoolApp_jan2025
//
//  Created by mac on 24/01/25.
//

import SwiftUI

struct StudentDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var studentDetailVM: StudentDetailViewModel
    
    var action: (StudentModel) -> Void
    
    init(formType: StudentFormType, student: StudentModel?, action: @escaping (StudentModel) -> Void) {
        _studentDetailVM = StateObject(wrappedValue: StudentDetailViewModel(formType: formType, student: student))
        self.action = action
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("First name", text: $studentDetailVM.firstname)
                    TextField("last name", text: $studentDetailVM.lastname)
                    TextField("Register Number", text: $studentDetailVM.registerNumber)
                } header: {
                    Text("Basic Details")
                }
                
                Section {
                    TextField("Age", text: $studentDetailVM.age)
                    Toggle("Is male", isOn: $studentDetailVM.isMale)
                } header: {
                    Text("Other Details")
                }
            }
            .navigationTitle(studentDetailVM.formType.formTitle)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(studentDetailVM.formType.buttonTitle) {
                        let newStudent = StudentModel(id: studentDetailVM.student?.id ?? UUID().uuidString,
                                                      firstName: studentDetailVM.firstname,
                                                      lastName: studentDetailVM.lastname,
                                                      regNo: studentDetailVM.registerNumber,
                                                      gender: studentDetailVM.isMale, age: studentDetailVM.age)
                        action(newStudent)
                        self.dismiss()
                    }
                    .disabled(studentDetailVM.disableButton)
                }
            }
        }
    }
}


//#Preview {
//    StudentDetailViewNew()
//}
