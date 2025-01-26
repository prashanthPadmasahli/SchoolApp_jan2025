//
//  ClassListView.swift
//  SchoolApp_jan2025
//
//  Created by mac on 24/01/25.
//

import SwiftUI

struct ClassListView: View {
    @ObservedObject var viewModel: SchoolViewModel
    let school: SchoolModel
    
    var body: some View {
        List {
            ForEach(school.classes) { clas in
                NavigationLink {
                    StudentListView(viewModel: viewModel, school: school, clas: clas)
                } label: {
                    classRow(clas: clas)
                }
            }
            .onDelete(perform: { indexSet in
                viewModel.deleteClass(from: school, at: indexSet)
            })
        }
        .overlay {
            if school.classes.isEmpty {
                NoResultsView(title: "Class")
            }
        }
        .modifier(OverlayAddButton(onTapped: {
            viewModel.showAddClass = true
        }))
        .navigationTitle(school.name)
        .alert("Add Class", isPresented: $viewModel.showAddClass, actions: {
            TextField("Class name", text: $viewModel.className)
            TextField("Teacher name", text: $viewModel.teacherName)
            Button("Cancel") { }
            Button("Add") {
                viewModel.addNewClass(for: school)
            }
            .disabled(viewModel.className.isEmpty)
        })
    }
    
    func classRow(clas: ClassModel) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(clas.name)
                Text(clas.teacher.isEmpty ? "NA" : clas.teacher)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text("\(clas.students.count) Stduents")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}
