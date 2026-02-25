//
//  ContentView.swift
//  List+FormLab
//
//  Created by Miles Norris on 2/25/26.
//

import SwiftUI

struct ContentView: View {
    @State var students: [Student] = [Student(name: "Miles Norris", idNumber: "99324888", schoolYear: "Senior"), Student(name: "Greg Smith", idNumber: "23746590", schoolYear: "Junior")]
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            Button {
                students.append(Student(name: "New Student", idNumber: "0", schoolYear: "Freshman"))
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.black)
                    .background {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.gray)
                            .opacity(0.3)
                    }
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)
            .padding(.bottom, 5)
            
            NavigationView {
                
                List {
                    Section {
                        ForEach($students) { student in
                            NavigationLink(destination: StudentDetailView(student: student)) {
                                HStack {
                                    VStack {
                                        Text(student.wrappedValue.name)
                                            .bold()
                                            .font(.title3)
                                        Text(student.wrappedValue.schoolYear)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("Student id")
                                            .font(.caption)
                                        Text(student.wrappedValue.idNumber)
                                    }
                                }
                                .padding(3)
                            }
                        }
                        .onDelete(perform: deleteStudent(at:))
                    } header: {
                        Text("Students")
                    }
                }
            }
        }
        .background {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        }
    }
    func deleteStudent(at offsets: IndexSet) {
        students.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
