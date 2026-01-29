//
//  ContentView.swift
//  Practice Project
//
//  Created by Miles Norris on 1/15/26.
//

import SwiftUI

@Observable
class StudentListViewModel {
    var students: [Student] = []
    
    var sortedStudents: [Student] {
        students.sorted {student1, student2 in
            student1.seatingPosition < student2.seatingPosition
        }
    }
}

struct StudentListView: View {
    @State var viewModel = StudentListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.sortedStudents) { student in
                NavigationLink {
                    Text("Hi")
                } label: {
                    VStack {
                        Text(student.firstName)
                        Text(student.lastName)
                    }
                }
            }
            .navigationTitle("Students")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        StudentDetailView(viewModel: $viewModel)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct StudentDetailView: View {
    @Binding var viewModel: StudentListViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var newStudent = Student.empty
    
    var body: some View {
        VStack {
            TextField("First Name", text: $newStudent.firstName)
            TextField("Last Name", text: $newStudent.lastName)
            TextField("Favorite Food", text: $newStudent.info.favoriteFood)
            TextField("Hair Color", text: $newStudent.info.hairColor)
            TextField("Seating position", text: $newStudent.seatingPositionString)
            
            Button("Save") {
                viewModel.students.append(newStudent)
                dismiss()
            }
        }
        .textFieldStyle(.roundedBorder)
        .padding(34)
    }
}

#Preview {
    StudentListView()
}
