//
//  AssignmentOutlineView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI
import MarkdownUI

struct AssignmentOutlineView: View {
    @Environment(\.dismiss) var dismiss
    let assignmentOutline: Assignment
    var body: some View {
        NavigationStack {
            ScrollView {
                Markdown(assignmentOutline.assignmentMarkdown)
                    .markdownTheme(.gitHub)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                    }
                }
            }
        }
    }
}

#Preview {
    AssignmentOutlineView(assignmentOutline: Assignment.assignments["Operators"]!)
}
