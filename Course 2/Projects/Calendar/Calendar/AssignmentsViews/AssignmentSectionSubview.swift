//
//  AssignmentSectionSubview.swift
//  Calendar
//
//  Created by Miles Norris on 4/3/26.
//

import SwiftUI

struct AssignmentSectionSubview: View {
    @Binding var assignmentToPresent: Assignment?
    let section: [Assignment]
    let sectionTitle: String
    var body: some View {
        if !section.isEmpty {
            Text(sectionTitle)
                .font(.system(size: 35))
                .bold()
                .padding(.vertical)
            
            ForEach(section) { assignment in
                Button {
                    assignmentToPresent = assignment
                } label: {
                    AssignmentSubview(assignment: assignment)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
