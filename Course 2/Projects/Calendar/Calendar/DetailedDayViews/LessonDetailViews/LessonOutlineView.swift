//
//  LessonOutlineView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI
import MarkdownUI

struct LessonOutlineView: View {
    @Environment(\.dismiss) var dismiss
    let lessonOutline: LessonOutline
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // Uses the MarkdownUI framework to display markdown data in a nice format.
                    Markdown(String(describing: lessonOutline.body))
                        .markdownTheme(.gitHub)
                        .padding()
                    
                    if !lessonOutline.objectives.isEmpty {
                        
                        Text("Objectives")
                            .font(.title)
                            .bold()
                            .padding(.top, 20)
                            .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                        
                        ForEach(lessonOutline.objectives, id: \.self) { objective in
                            HStack {
                                Text("•")
                                    .bold()
                                
                                Text(objective.description)
                            }
                            .padding(.vertical, 3)
                        }
                        .padding(.horizontal, 30)
                    }
                    
                    if !lessonOutline.schedule.isEmpty {
                        
                        Text("Schedule")
                            .font(.title)
                            .bold()
                            .padding(.top, 20)
                            .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                        
                        ForEach(lessonOutline.schedule, id: \.self) { item in
                            HStack {
                                Text("\(item.startTime.hour):\(item.startTime.minute)-\(item.endTime.hour):\(item.endTime.minute)")
                                
                                Text("-")
                                
                                Text(item.task)
                            }
                            .padding(.vertical, 3)
                        }
                        .padding(.horizontal, 30)
                    }
                    
                    if lessonOutline.body.isEmpty && lessonOutline.objectives.isEmpty && lessonOutline.schedule.isEmpty {
                        Text("No Lesson Today")
                        .foregroundStyle(Color.gray)
                        .font(.title2)
                        .bold()
                        .italic()
                    }
                }
            }
            .navigationTitle(lessonOutline.name)
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

