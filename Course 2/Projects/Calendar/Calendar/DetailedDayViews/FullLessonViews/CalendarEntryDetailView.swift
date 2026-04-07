//
//  CalendarEntryDetailView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI
import MarkdownUI

struct CalendarEntryDetailView: View {
    let currentEntry: CalendarEntry
    
    @State var viewModel: CalendarEntryDetailViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                DateHeaderView(currentEntry: currentEntry, viewModel: viewModel)
                
                LessonInfoView(currentEntry: currentEntry, viewModel: viewModel)
                
                Divider()
                    .padding(.bottom, 15)
                
                WorkDueView(currentEntry: currentEntry, viewModel: viewModel)
                
                Divider()
                    .padding(.top)
                
                NewAssignmentsView(currentEntry: currentEntry, viewModel: viewModel)
                
                CodeChallengeView(currentEntry: currentEntry)
                
                WordOfTheDayView(currentEntry: currentEntry)
            }
            .padding(.horizontal, 20)
        }
        // I have two different sheets here, one for the details of the lesson, and one that will display the details of any assignment that is tapped.
        .sheet(isPresented: $viewModel.isLessonOutlinePresented) {
            LessonOutlineView(lessonOutline: LessonOutline.lessonOutlines[currentEntry.lessonName]!)
        }
        .sheet(item: $viewModel.assignmentToDisplay) { assignmentToDisplay in
            AssignmentOutlineView(assignment: $viewModel.assignmentToDisplay)
        }
    }
    
    struct DateHeaderView: View {
        let currentEntry: CalendarEntry
        let viewModel: CalendarEntryDetailViewModel
        
        var body: some View {
            HStack(spacing: 20) {
                Text(currentEntry.date)
                    .font(.system(size: 45))
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 15)
                
                Divider()
                    .frame(height: 60)
                
                Text(currentEntry.lessonID)
                    .font(.system(size: 45))
                    .bold()
                    .underline()
                    .foregroundStyle(.blue)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 15)
                    .onTapGesture {
                        viewModel.lessonOutlinePressed()
                    }
                
            }
            .padding(5)
            .padding(.top, 10)
            
        }
    }
    
    struct LessonInfoView: View {
        let currentEntry: CalendarEntry
        let viewModel: CalendarEntryDetailViewModel
        
        var body: some View {
            HStack {
                Spacer()
                Text("Lesson")
                    .font(.title2)
                    .bold()
                    .padding(.top, 20)
                Spacer()
            }
            
            Divider()
            
            Text(currentEntry.lessonName)
                .font(.system(size: 50))
                .bold()
                .lineLimit(2)
                .minimumScaleFactor(0.1)
                .padding(.bottom, 35)
                .onTapGesture {
                    viewModel.lessonOutlinePressed()
                }
            
            Text(currentEntry.mainObjective)
                .font(.system(size: 18))
                .bold()
                .padding(.bottom, 20)
        }
    }
    
    struct WorkDueView: View {
        let currentEntry: CalendarEntry
        let viewModel: CalendarEntryDetailViewModel
        
        var body: some View {
            Text("Work Due")
                .font(.system(size: 35))
                .bold()
                .padding(.bottom, 10)
            
            if let reading = currentEntry.readingDue, let assignments = currentEntry.assignmentsDue {
                Text("Reading")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 5)
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(reading, id: \.self) { item in
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("•")
                                .font(.body)
                            Text(item)
                                .bold()
                                .font(.body)
                        }
                    }
                }
                
                Divider()
                    .frame(width: 220)
                
                Text("Assignments")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 5)
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(assignments, id: \.self) { item in
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("•")
                                .font(.body)
                            Text(item)
                                .bold()
                                .font(.body)
                                .underline()
                                .foregroundStyle(.blue)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 8)
                                .onTapGesture {
                                    viewModel.assignmentOutlinePressed(Assignment.assignments[item]!)
                                }
                        }
                    }
                }
            } else {
                Text("No Work Due Today")
                    .foregroundStyle(Color.gray)
                    .bold()
                    .italic()
            }
        }
    }
    
    struct NewAssignmentsView: View {
        let currentEntry: CalendarEntry
        let viewModel: CalendarEntryDetailViewModel
        
        var body: some View {
            Text("New Assignments")
                .font(.system(size: 30))
                .bold()
                .padding(.top, 15)
                .padding(.bottom, 10)
            
            if let assignments = currentEntry.newAssignments {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(assignments, id: \.self) { item in
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("•")
                                .font(.title3)
                            Text(item)
                                .bold()
                                .font(.title3)
                                .underline()
                                .foregroundStyle(.blue)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 8)
                                .onTapGesture {
                                    viewModel.assignmentOutlinePressed(Assignment.assignments[item]!)
                                }
                        }
                    }
                }
            } else {
                Text("No New Assignments Today")
                    .foregroundStyle(Color.gray)
                    .bold()
                    .italic()
            }
        }
    }
    
    struct CodeChallengeView: View {
        let currentEntry: CalendarEntry
        
        var body: some View {
            HStack {
                Spacer()
                Text("Code Challenge")
                    .font(.title2)
                    .bold()
                    .padding(.top, 30)
                Spacer()
            }
            
            Divider()
            
            Text(currentEntry.codeChallengeName)
                .font(.system(size: 18))
                .bold()
                .padding(.top, 10)
        }
    }
    
    struct WordOfTheDayView: View {
        let currentEntry: CalendarEntry
        
        var body: some View {
            HStack {
                Spacer()
                Text("Word Of the Day")
                    .font(.title2)
                    .bold()
                    .padding(.top, 30)
                Spacer()
            }
            
            Divider()
            
            HStack {
                Spacer()
                Text(currentEntry.wordOfTheDay)
                    .font(.title)
                    .bold()
                    .padding(.top, 10)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    CalendarEntryDetailView(currentEntry: CalendarEntry.calendarEntrys[2], viewModel: CalendarEntryDetailViewModel())
}
