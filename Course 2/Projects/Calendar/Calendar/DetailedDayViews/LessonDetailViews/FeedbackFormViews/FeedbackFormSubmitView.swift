//
//  FeedbackFormSubmitView.swift
//  Calendar
//
//  Created by Miles Norris on 4/2/26.
//

import SwiftUI

struct FeedbackFormSubmitView: View {
    @Binding var viewModel: FeedbackFormViewModel
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                FormTitleView(viewModel: $viewModel)
                
                Question1View(viewModel: $viewModel)
                
                Question2View(viewModel: $viewModel)
                
                Question3View(viewModel: $viewModel)
               
                SubmitButtonView(viewModel: viewModel)
               
                Spacer()
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
    
    struct FormTitleView: View {
        @Binding var viewModel: FeedbackFormViewModel
        
        var body: some View {
            HStack {
                Spacer()
                Text(viewModel.selectedLesson?.lessonName ?? "")
                    .font(.system(size: 40, design: .rounded))
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.bottom, 40)
        }
    }
    
    struct Question1View: View {
        @Binding var viewModel: FeedbackFormViewModel
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            Text("What went well in today's lesson?")
                .font(.title3)
                .bold()
                .padding(.horizontal, 10)
            
            TextField("Optional", text: $viewModel.whatWentWellText)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                }
                .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.35 : 0.08), radius: 10, x: 0, y: 6)
                .padding(.bottom, 30)
        }
    }
    
    struct Question2View: View {
        @Binding var viewModel: FeedbackFormViewModel
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            Text("What are you still confused about?")
                .font(.title3)
                .bold()
                .padding(.horizontal, 10)
            
            TextField("Optional", text: $viewModel.whatWasConfusingText)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                }
                .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.35 : 0.08), radius: 10, x: 0, y: 6)
                .padding(.bottom, 30)
        }
    }
    
    struct Question3View: View {
        @Binding var viewModel: FeedbackFormViewModel
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            Text("What Suggestions for activities or changes to the lesson do you have?")
                .font(.title3)
                .bold()
                .padding(.horizontal, 10)
            
            TextField("Optional", text: $viewModel.whatSuggestionsText)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                }
                .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.35 : 0.08), radius: 10, x: 0, y: 6)
                .padding(.bottom, 30)
            
        }
    }
    
    struct SubmitButtonView: View {
        @Environment(\.dismiss) var dismiss
        @Environment(\.colorScheme) var colorScheme
        let viewModel: FeedbackFormViewModel
        var body: some View {
            HStack {
                Spacer()
                
                Button {
                    Task {
                        do {
                            try await viewModel.submitLessonFeedback()
                            dismiss()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    Text("Submit")
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
                
                Spacer()
            }
        }
    }
}

