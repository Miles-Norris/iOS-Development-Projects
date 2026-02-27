//
//  StudentDetailView.swift
//  List+FormLab
//
//  Created by Miles Norris on 2/25/26.
//

import SwiftUI

struct StudentDetailView: View {
    @Binding var student: Student
    
    var body: some View {
        Form {
            Section(header: Text("Student Info")) {
                HStack {
                    Text("Name:")
                    TextField("Full Name", text: $student.name)
                }
                HStack {
                    Text("Student ID:")
                    TextField("Student ID", text: $student.idNumber)
                }
                Picker("School Year:  \(student.schoolYear)", selection: $student.schoolYear) {
                    ForEach(Student.schoolYears, id: \.self) { year in
                        Text(year)
                    }
                }
                .pickerStyle(.automatic)
            }
        }
    }
}

#Preview {
    StudentDetailView(student: .constant(Student(name: "Miles Norris", idNumber: "32467888", schoolYear: "Senior")))
}
