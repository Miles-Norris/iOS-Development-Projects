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
    @Binding var assignment: Assignment?
    var body: some View {
        NavigationStack {
            if let assignmentValue = assignment {
                ScrollView {
                    // Uses the MarkdownUI framework to display markdown data in a nice format.
                    Markdown(assignmentValue.assignmentMarkdown)
                        .markdownTheme(.gitHub)
                        .padding()
                    
                    Button {
                        // Does nothing at the moment, will make a network call when the API is implemented.
                        dismiss()
                    } label: {
                        Text((assignment?.isComplete ?? false) ? "Mark Incomplete" : "Mark Complete")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(10)
                            .padding(.horizontal, 10)
                            .background {
                                Capsule()
                            }
                    }
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
}

#Preview {
    @Previewable @State var assignent: Assignment? =  Assignment.assignments["Operators"]!
    AssignmentOutlineView(assignment: $assignent)
}
