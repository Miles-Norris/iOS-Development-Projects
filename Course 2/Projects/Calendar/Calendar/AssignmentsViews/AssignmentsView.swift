//
//  AssignmentsView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI


// This is doing the same thing as the main calendar view, displaying a subview for each section that in turn displays subviews for each lesson.
struct AssignmentsView: View {
    @State var assignmentToPresent: Assignment?
    
    @Binding var assignmentsStore: AssignmentStore
    
    @State var sectionData: [String: [Assignment]] = [:]
    
    let currentUser: User
    
    var body: some View {
        if assignmentsStore.assignments.count < 35 {
            ProgressView()
        } else {
            ScrollView {
                HStack {
                    Image(systemName: "checkmark.seal.text.page")
                        .foregroundStyle(Color.accentColor)
                        .font(.system(size: 34))
                    
                    Text("Assignments")
                        .bold()
                        .font(.system(size: 42, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
                VStack(alignment: .leading) {
                    ForEach(CalendarStore.sections, id: \.self) { section in
                        if sectionData[section] != nil {
                            AssignmentSectionSubview(assignmentToPresent: $assignmentToPresent, section: sectionData[section]!, sectionTitle: section)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .sheet(item: $assignmentToPresent) { assignment in
                AssignmentOutlineView(assignment: $assignmentToPresent, currentUser: currentUser)
            }
            .onAppear {
                sectionData = ["Swift Fundamentals": assignmentsStore.SFassignments, "Tables And Persistence": assignmentsStore.TPassignments, "Networking And Data Storage": assignmentsStore.NDassignments, "Special Topics": assignmentsStore.STassignments, "Full App Development": assignmentsStore.FAassignments, "Prototype And Project Planning": assignmentsStore.PCassignments, "Group Capstone": assignmentsStore.GCassignments]
            }
        }
    }
}

