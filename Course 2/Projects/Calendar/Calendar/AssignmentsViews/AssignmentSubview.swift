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
    var body: some View {
        HStack {
            Spacer()
            
            Text(assignment.assignmentTitle)
                .font(.system(size: 26))
                .bold()
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                
            Spacer()
            
            Divider()
                .frame(width: 35, height: 65)
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("Due")
                    .font(.system(size: 17))
                    .bold()
                
                Text(assignment.dueDate)
                    .font(.system(size: 20))
                    .bold()
            }
            
            Spacer()
            
            Image(systemName: assignment.isComplete ? "checkmark.square" : "square")
                .font(.system(size: 28))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .padding(.bottom, 8)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(colorScheme == .dark ? .black : .white)
                .shadow(color: colorScheme == .dark ? .white.opacity(0.3) : .black.opacity(0.15), radius: 5, x: 0, y: 0)
                .frame(minHeight: 80)
                .frame(minWidth: 350)
                .frame(maxWidth: 350)
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
        }
        .frame(minHeight: 80)
        .frame(minWidth: 350)
        .frame(maxWidth: 350)
    }
}

#Preview {
    AssignmentSubview(assignment: Assignment.assignments["Strings"]!)
}
