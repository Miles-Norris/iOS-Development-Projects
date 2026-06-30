//
//  AssignmentSubview.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct AssignmentSubview: View {
    @Environment(\.colorScheme) var colorScheme
    let assignment: Assignment

    private var status: (label: String, color: Color, isComplete: Bool) {
        let progress = assignment.userProgress?.lowercased()
        if progress == "complete" {
            return ("Complete", .green, true)
        } else if progress == "inProgress" {
            return ("In Progress", .blue, false)
        } else {
            return ("Not Started", .red, false)
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                .fill(status.color.opacity(0.9))
                .frame(width: 4)

            Image(systemName: status.isComplete ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(status.color)
                .accessibilityLabel(status.isComplete ? "Completed" : "Not Completed")

            VStack(alignment: .leading, spacing: 6) {
                Text("\(assignment.name) - \(assignment.assignmentType == "lab" ? "Lab" : "Project")")
                    .font(.system(size: 18, weight: .bold))
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)

                HStack(spacing: 8) {
                    Text(status.label)
                        .font(.system(size: 12, weight: .semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule().fill(status.color.opacity(0.15))
                        )
                        .foregroundStyle(status.color)

                    Circle()
                        .fill(.secondary)
                        .frame(width: 4, height: 4)
                        .opacity(assignment.dueOn == nil ? 0 : 1)

                    if let dueOn = assignment.dueOn {
                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.secondary)
                            Text("Due ")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.secondary)
                            Text(dueOn)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(colorScheme == .dark ? .white : .primary)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(14)
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Color.black.opacity(colorScheme == .dark ? 0.25 : 0.08), lineWidth: 0.5)
        )
        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.35 : 0.08), radius: 10, x: 0, y: 6)
        .frame(minWidth: 350)
        .frame(maxWidth: 350)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Assignment, \(assignment.name). Status: \(status.label)\(assignment.dueOn != nil ? ", due on \(assignment.dueOn!)" : "")")
    }
}
