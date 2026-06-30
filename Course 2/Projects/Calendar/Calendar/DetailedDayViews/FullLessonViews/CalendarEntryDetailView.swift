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
    
    let currentUser: User
    
    @State var viewModel: CalendarEntryDetailViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                DateHeaderView(currentEntry: currentEntry, viewModel: viewModel)
                Divider()
                LessonInfoView(currentEntry: currentEntry, viewModel: viewModel)
                Divider()
                WorkDueView(currentEntry: currentEntry, viewModel: viewModel)
                Divider()
                NewAssignmentsView(currentEntry: currentEntry, viewModel: viewModel)
                Divider()
                CodeChallengeView(currentEntry: currentEntry)
                Divider()
                WordOfTheDayView(currentEntry: currentEntry)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
        .background(Color(.systemBackground))
        // I have two different sheets here, one for the details of the lesson, and one that will display the details of any assignment that is tapped.
        .sheet(isPresented: $viewModel.isLessonOutlinePresented) {
            if let outline = viewModel.lessonOutlineToPresent {
                LessonOutlineView(lessonOutline: outline)
            }
        }
        .sheet(item: $viewModel.assignmentToDisplay) { assignmentToDisplay in
            AssignmentOutlineView(assignment: $viewModel.assignmentToDisplay, currentUser: currentUser)
        }
    }
    
    struct DateHeaderView: View {
        let currentEntry: CalendarEntry
        let viewModel: CalendarEntryDetailViewModel
        
        var body: some View {
            HStack(spacing: 16) {
                Text(currentEntry.date)
                    .font(.system(size: 34, weight: .bold, design: .rounded))

                Divider()
                    .frame(height: 28)

                if let id = currentEntry.dayID {
                    Text(id)
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.accentColor)
                        .onTapGesture {
                            Task {
                                do {
                                    try await viewModel.getLessonOutline(currentEntry: currentEntry)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                }
                
                Spacer(minLength: 0)
            }
        }
    }
    
    struct LessonInfoView: View {
        let currentEntry: CalendarEntry
        let viewModel: CalendarEntryDetailViewModel
        
        var body: some View {
            HStack(spacing: 8) {
                Image(systemName: "book.fill")
                    .foregroundStyle(Color.accentColor)
                Text("Lesson")
                    .font(.title2).bold()
                Spacer()
            }
            .padding(.bottom, 5)
        
            if let lessonName = currentEntry.lessonName {
                Text(lessonName)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .onTapGesture {
                        Task {
                            do {
                                try await viewModel.getLessonOutline(currentEntry: currentEntry)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    .padding(.bottom, 4)
            }
            
            if let objective = currentEntry.mainObjective {
                if objective.isEmpty {
                    Text("No Lesson Overview Today")
                        .foregroundStyle(.secondary)
                        .italic().bold()
                        .padding(.bottom, 4)
                } else {
                    Text(objective)
                        .font(.body.weight(.semibold))
                        .padding(.bottom, 4)
                }
            }
        }
    }
    
    struct WorkDueView: View {
        let currentEntry: CalendarEntry
        let viewModel: CalendarEntryDetailViewModel
        
        var body: some View {
            HStack(spacing: 8) {
                Image(systemName: "checklist")
                    .foregroundStyle(Color.accentColor)
                Text("Work Due")
                    .font(.title2).bold()
                Spacer()
            }
            .padding(.bottom, 6)
            
            if let reading = currentEntry.readingDue, !currentEntry.assignmentsDue.isEmpty {
                if !reading.isEmpty {
                    Text("Reading")
                        .font(.headline).bold()
                    Text(reading)
                        .font(.body.weight(.semibold))
                    
                    Divider().padding(.vertical, 3)
                }
                
                Text("Assignments")
                    .font(.headline).bold()
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(currentEntry.assignmentsDue) { item in
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("•").font(.body)
                            Text(item.name)
                                .font(.body.weight(.semibold))
                                .foregroundStyle(Color.accentColor)
                                .onTapGesture { viewModel.assignmentOutlinePressed(item) }
                        }
                    }
                }
            } else {
                Text("No Work Due Today")
                    .foregroundStyle(.secondary)
                    .italic().bold()
                    .padding(.vertical, 6)
            }
        }
    }
    
    struct NewAssignmentsView: View {
        let currentEntry: CalendarEntry
        let viewModel: CalendarEntryDetailViewModel
        
        var body: some View {
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .foregroundStyle(Color.accentColor)
                Text("New Assignments")
                    .font(.title2).bold()
                Spacer()
            }
            .padding(.bottom, 6)
            
            if !currentEntry.newAssignments.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(currentEntry.newAssignments) { item in
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("•").font(.title3)
                            Text(item.name)
                                .font(.body.weight(.semibold))
                                .foregroundStyle(Color.accentColor)
                                .onTapGesture { viewModel.assignmentOutlinePressed(item) }
                        }
                    }
                }
            } else {
                Text("No New Assignments Today")
                    .foregroundStyle(.secondary)
                    .italic().bold()
                    .padding(.top, 4)
            }
        }
    }
    
    struct CodeChallengeView: View {
        let currentEntry: CalendarEntry
        
        var body: some View {
            HStack(spacing: 8) {
                Image(systemName: "curlybraces.square.fill")
                    .foregroundStyle(Color.accentColor)
                Text("Code Challenge")
                    .font(.title2).bold()
                Spacer()
            }
            
            if let codeChallenge = currentEntry.dailyCodeChallengeName {
                Text(codeChallenge)
                    .font(.body.weight(.semibold))
                    .padding(.top, 6)
            } else {
                Text("No Code Challenge Today")
                    .foregroundStyle(.secondary)
                    .italic().bold()
                    .padding(.top, 4)
            }
        }
    }
    
    struct WordOfTheDayView: View {
        let currentEntry: CalendarEntry
        
        var body: some View {
            HStack(spacing: 8) {
                Image(systemName: "text.book.closed.fill")
                    .foregroundStyle(Color.accentColor)
                Text("Word Of the Day")
                    .font(.title2).bold()
                Spacer()
            }
            
            if let wordOfTheDay = currentEntry.wordOfTheDay {
                HStack {
                    Spacer()
                    Text(wordOfTheDay)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color.accentColor)
                    Spacer()
                }
                .padding(.top, 6)
            } else {
                Text("No Word Of The Day Today")
                    .foregroundStyle(.secondary)
                    .italic().bold()
                    .padding(.top, 4)
            }
        }
    }
}

