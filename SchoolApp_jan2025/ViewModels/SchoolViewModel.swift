//
//  SchoolViewModel.swift
//  SchoolApp_jan2025
//
//  Created by mac on 23/01/25.
//

import Foundation

class SchoolViewModel: ObservableObject {
    /// School
    @Published var schools: [SchoolModel] = [] {
        didSet {
            print("scools updated")
            self.saveSchoolData(schools: schools)
        }
    }
    @Published var showAddSchool = false
    @Published var schoolName = ""
    @Published var schoolAddress = ""
    
    /// Class
    @Published var showAddClass = false
    @Published var className = ""
    @Published var teacherName = ""
    
    /// Student
    @Published var showAddStudent = false
    
    init() {
        self.schools = self.fetchSchoolData()
    }
    
    // MARK: - School methods
    func addNewSchool() {
        let newSchool = SchoolModel(name: schoolName, address: schoolAddress)
        schools.append(newSchool)
        resetScoolData()
    }
    
    func resetScoolData() {
        self.schoolName = ""
        self.schoolAddress = ""
    }
    
    func deleteSchool(at offsets: IndexSet) {
        schools.remove(atOffsets: offsets)
    }
    
    // MARK: - Class methods
    func addNewClass(for school: SchoolModel) {
        let newClass = ClassModel(name: className, teacher: teacherName)
        if let index = schools.firstIndex(where: { $0.id == school.id}) {
            schools[index].classes.append(newClass)
        }
        resetClassData()
    }
    
    func resetClassData() {
        self.className = ""
        self.teacherName = ""
    }
    
    func deleteClass(from school: SchoolModel, at offset: IndexSet) {
        if let index = schools.firstIndex(where: { $0.id == school.id}) {
            schools[index].classes.remove(atOffsets: offset)
        }
    }
    
    // MARK: - Student methods
    func addNewStudent(for school: SchoolModel, clas: ClassModel, student: StudentModel) {
        if let schoolIndex = schools.firstIndex(where: { $0.id == school.id}),
           let classIndex = schools[schoolIndex].classes.firstIndex(where: {$0.id == clas.id}) {
            schools[schoolIndex].classes[classIndex].students.append(student)
        }
    }
    
    func updateStudent(for school: SchoolModel, clas: ClassModel, student: StudentModel) {
        if let schoolIndex = schools.firstIndex(where: { $0.id == school.id}),
           let classIndex = schools[schoolIndex].classes.firstIndex(where: {$0.id == clas.id}),
           let studentIndex = schools[schoolIndex].classes[classIndex].students.firstIndex(where: {$0.id == student.id}) {
            schools[schoolIndex].classes[classIndex].students[studentIndex] = student
        }
    }
    
    func deleteStudent(from school: SchoolModel, clas: ClassModel, at offset: IndexSet) {
        if let schoolIndex = schools.firstIndex(where: { $0.id == school.id}),
           let classIndex = schools[schoolIndex].classes.firstIndex(where: {$0.id == clas.id}) {
            schools[schoolIndex].classes[classIndex].students.remove(atOffsets: offset)
        }
    }
    
    // MARK: - Database operations
    func saveSchoolData(schools: [SchoolModel]) {
        do {
            let data = try JSONEncoder().encode(schools)
            UserDefaults.standard.set(data, forKey: "school")
        } catch {
            print("Error while saving students")
        }
    }
    
    func fetchSchoolData() -> [SchoolModel] {
        guard let data = UserDefaults.standard.data(forKey: "school") else { return [] }
        do {
            let schools = try JSONDecoder().decode([SchoolModel].self, from: data)
            return schools
        } catch {
            print("Error while Fetching students")
            return []
        }
    }
}
