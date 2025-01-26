//
//  SchoolListView.swift
//  SchoolApp_jan2025
//
//  Created by mac on 23/01/25.
//

import SwiftUI

struct SchoolListView: View {
    @StateObject var viewModel = SchoolViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.schools) { school in
                    NavigationLink {
                        ClassListView(viewModel: viewModel, school: school)
                    } label: {
                        schoolRow(school: school)
                    }
                }
                .onDelete(perform: viewModel.deleteSchool)
            }
            .overlay {
                if viewModel.schools.isEmpty {
                    NoResultsView(title: "Schools")
                }
            }
            .modifier(OverlayAddButton(onTapped: {
                viewModel.showAddSchool = true
            }))
            .navigationTitle("Schools")
            .alert("Add school", isPresented: $viewModel.showAddSchool, actions: {
                TextField("School name", text: $viewModel.schoolName)
                TextField("School Address", text: $viewModel.schoolAddress)
                Button("Cancel") { }
                Button("Add") {
                    viewModel.addNewSchool()
                }
                .disabled(viewModel.schoolName.count<3)
            })
        }
    }
    
    func schoolRow(school: SchoolModel) -> some View {
        VStack(alignment: .leading) {
            Text(school.name)
            Text(school.address.isEmpty ? "NA" : school.address)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SchoolListView()
}
