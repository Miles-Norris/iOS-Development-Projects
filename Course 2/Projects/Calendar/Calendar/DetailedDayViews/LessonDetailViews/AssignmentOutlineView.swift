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
    @Binding var assignmentStore: AssignmentStore
    @Binding var calendarStore: CalendarStore
    
    @State var loading = false
    
    let currentUser: User
    var body: some View {
        NavigationStack {
            if loading {
                ProgressView()
            } else {
                if let assignmentValue = assignment {
                    ScrollView {
                        // Uses the MarkdownUI framework to display markdown data in a nice format.
                        if let body = assignmentValue.body, !body.isEmpty {
                            Markdown(String(describing: body))
                                .markdownTheme(.gitHub)
                                .padding()
                        } else {
                            Text("No Assignment Outline")
                                .foregroundStyle(Color.gray)
                                .font(.title2)
                                .bold()
                                .italic()
                                .padding(.vertical, 20)
                                .padding(.top, 15)
                        }
                        
                        Button {
                            var newProgress: String {
                                if assignmentValue.userProgress == "notStarted" {
                                    return "inProgress"
                                } else if assignmentValue.userProgress == "inProgress" {
                                    return "complete"
                                } else if assignmentValue.userProgress == "complete" {
                                    return "notStarted"
                                } else {
                                    return "inProgress"
                                }
                            }
                            Task {
                                do {
                                    loading = true
                                    try await postAssignmentProgress(newProgress: newProgress)
                                    try await getAssignmentData()
                                    assignmentStore.filterAssignments(calendarEntries: calendarStore.calendarEntries)
                                    loading = false
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
                                    return "Start"
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
    }
    
    func postAssignmentProgress(newProgress: String) async throws {
        if let id = assignment?.id {
             assignment = try await DataFetcher.shared.fetchData(UpdateAssignmentProgressAPIRequest(secret: currentUser.secret, body: AssignmentProgressPostBody(assignmentID: id, progress: newProgress)))
        }
    }
    
    func getAssignmentData() async throws {
        async let assignmentsResult = DataFetcher.shared.fetchData(
            AssignmentAPIRequest(endpoint: "/assignment/all", isReturningArray: true, secret: currentUser.secret)
        )
        
        let allAssignments = try await assignmentsResult as! [Assignment]
        
        let detailedAssignments: [Assignment] = try await withThrowingTaskGroup(of: Assignment?.self) { group in
            for assignment in allAssignments {
                group.addTask {
                    var detailed = try await DataFetcher.shared.fetchData(
                        AssignmentAPIRequest(endpoint: "/assignment/\(assignment.id)", isReturningArray: false, secret: self.currentUser.secret)
                    ) as! Assignment
                    detailed.dueOn = await formatMonthDay(from: detailed.dueOn ?? "") ?? ""
                    return detailed
                }
            }

            var collected: [Assignment] = []
            collected.reserveCapacity(allAssignments.count)
            for try await maybeAssignment in group {
                if let a = maybeAssignment {
                    collected.append(a)
                }
            }
            return collected
        }
        
        await MainActor.run {
            assignmentStore.assignments = detailedAssignments
        }
    }
}

