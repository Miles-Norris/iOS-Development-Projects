//
//  AssignmentOutlineView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI
import MarkdownUI

struct AssignmentOutlineView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Binding var assignment: Assignment?
    
    let currentUser: User
    var body: some View {
        NavigationStack {
            if let assignmentValue = assignment {
                ScrollView {
                    // Uses the MarkdownUI framework to display markdown data in a nice format.
                    if let body = assignmentValue.body {
                        Markdown(String(describing: body))
                            .markdownTheme(.gitHub)
                            .padding()
                    }
                    
                    Button {
                        var newProgress: String {
                            if assignmentValue.userProgress == "notStarted" {
                                return "inProgress"
                            } else if assignmentValue.userProgress == "inProgress" {
                                return "complete"
                            } else {
                                return "inProgress"
                            }
                        }
                        Task {
                            do {
                                try await postAssignmentProgress(newProgress: newProgress)
                                dismiss()
                            } catch {
                                print(error.localizedDescription)
                                dismiss()
                            }
                        }
                    } label: {
                        var text: String {
                            if assignmentValue.userProgress == "notStarted" {
                                return "Start"
                            } else if assignmentValue.userProgress == "inProgress" {
                                return "Complete"
                            } else if assignmentValue.userProgress == "complete" {
                                return "Mark Incomplete"
                            } else {
                                return ""
                            }
                        }
                        Text(text)
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(10)
                            .padding(.horizontal, 10)
                            .background {
                                Capsule()
                            }
                            .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.35 : 0.08), radius: 10, x: 0, y: 6)
                    }
                    .padding(.top, 30)
                }
                .navigationTitle(assignmentValue.name)
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
    
    func postAssignmentProgress(newProgress: String) async throws {
        if let id = assignment?.id {
             assignment = try await DataFetcher.shared.fetchData(UpdateAssignmentProgressAPIRequest(secret: currentUser.secret, body: AssignmentProgressPostBody(assignmentID: id, progress: newProgress)))
        }
    }
}

