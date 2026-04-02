//
//  FeedbackFormSelectView.swift
//  Calendar
//
//  Created by Miles Norris on 4/2/26.
//

import SwiftUI

struct FeedbackFormSelectView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var viewModel: FeedbackFormViewModel
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Text("Select a Lesson")
                        .font(.system(size: 30))
                        .bold()
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                        
                        TextField("Search", text: $viewModel.searchText)
                            .frame(width: 250, height: 50)
                            .textInputAutocapitalization(.none)
                            .autocorrectionDisabled(true)
                        
                        if !viewModel.searchText.isEmpty {
                            Button {
                                viewModel.searchBarClear()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.systemGray6))
                    }
                    Spacer()
                }
                .padding(.bottom)
                
                ForEach(viewModel.filteredLessons) { lesson in
                    Button {
                        viewModel.lessonSelected(lesson: lesson)
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "book.closed")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(lesson.lessonName)
                                    .font(.headline)
                                
                                Text("\(lesson.lessonID) • \(lesson.date)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.footnote)
                                .foregroundStyle(.tertiary)
                        }
                        .contentShape(Rectangle())
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
            .padding()
            .onChange(of: viewModel.searchText) {
                viewModel.allLessonsFiltered()
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

