//
//  AssignmentsView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct AssignmentSection: Identifiable {
    let id = UUID()
    let title: String
    var assignments: [Assignment]
}

// This is doing the same thing as the main calendar view, displaying a subview for each section that in turn displays subviews for each lesson.
struct AssignmentsView: View {
    @State var sections: [AssignmentSection] = []
    
    @State var assignmentToPresent: Assignment?
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(sections.indices, id: \.self) { index in
                    AssignmentSectionSubview(assignmentToPresent: $assignmentToPresent, section: sections[index].assignments, sectionTitle: sections[index].title)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .sheet(item: $assignmentToPresent) { assignment in
            AssignmentOutlineView(assignment: $assignmentToPresent)
        }
        .onAppear {
            Assignment.filterAssignments()
            sections = [
                AssignmentSection(title: "Swift Fundamentals", assignments: Assignment.SFassignments),
                AssignmentSection(title: "Tables And Persistence", assignments: Assignment.TPassignments),
                AssignmentSection(title: "Networking And Data Storage", assignments: Assignment.NDassignments),
                AssignmentSection(title: "Special Topics", assignments: Assignment.STassignments),
                AssignmentSection(title: "Full App Development", assignments: Assignment.FAassignments),
                AssignmentSection(title: "Prototype And Project Planning", assignments: Assignment.PCassignments),
                AssignmentSection(title: "Group Capstone", assignments: Assignment.GCassignments)
            ]
        }
    }
}

#Preview {
    AssignmentsView()
}
