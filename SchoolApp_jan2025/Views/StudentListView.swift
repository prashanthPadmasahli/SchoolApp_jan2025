//
//  StudentListView.swift
//  SchoolApp_jan2025
//
//  Created by mac on 24/01/25.
//

import SwiftUI

struct StudentListView: View {
    @ObservedObject var viewModel: SchoolViewModel
    let school: SchoolModel
    let clas: ClassModel
    
    @State var searchText = ""
    
    var filteredStudents: [StudentModel] {
        if searchText.isEmpty {
            return clas.students
        } else {
            return clas.students.filter({($0.firstName + $0.lastName).contains(searchText)})
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredStudents) { student in
                NavigationLink {   /// Updating existing students here
                    StudentDetailView(formType: .update, student: student) { student in
                        viewModel.updateStudent(for: school, clas: clas, student: student)
                    }
                } label: {
                    studentRow(student: student)
                }
            }
            .onDelete(perform: { indexSet in
                viewModel.deleteStudent(from: school, clas: clas, at: indexSet)
            })
        }
        .overlay {
            if clas.students.isEmpty {
                NoResultsView(title: "Students")
            }
        }
        .modifier(OverlayAddButton(onTapped: {
            viewModel.showAddStudent = true
        }))
        .sheet(isPresented: $viewModel.showAddStudent) { /// Adding new students here
            StudentDetailView(formType: .addNew, student: nil, action: { student in
                viewModel.addNewStudent(for: school, clas: clas, student: student)
            })
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search students")
        .navigationTitle(clas.name)
    }
    
    func studentRow(student: StudentModel) -> some View {
        VStack(alignment: .leading) {
            Text(student.firstName + " " + student.lastName)
            Text("Reg No: " + student.regNo)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

