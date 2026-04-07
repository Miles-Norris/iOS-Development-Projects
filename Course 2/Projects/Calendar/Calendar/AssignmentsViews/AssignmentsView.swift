//
//  AssignmentsView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI


// This is doing the same thing as the main calendar view, displaying a subview for each section that in turn displays subviews for each lesson.
struct AssignmentsView: View {
    @State var viewModel: AssignmentsViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(CalendarEntry.sections, id: \.self) { section in
                    AssignmentSectionSubview(assignmentToPresent: $viewModel.assignmentToPresent, section: viewModel.sectionData[section]!, sectionTitle: section)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .sheet(item: $viewModel.assignmentToPresent) { assignment in
            AssignmentOutlineView(assignment: $viewModel.assignmentToPresent)
        }
    }
}

