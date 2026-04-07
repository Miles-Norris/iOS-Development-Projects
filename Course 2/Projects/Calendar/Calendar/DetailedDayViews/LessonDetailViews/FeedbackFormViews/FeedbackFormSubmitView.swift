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
               
                SubmitButtonView()
               
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
                    .font(.system(size: 40))
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .padding()
                Spacer()
            }
            .padding(.bottom, 40)
        }
    }
    
    struct Question1View: View {
        @Binding var viewModel: FeedbackFormViewModel
        
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
                    
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.gray)
                }
                .padding(.bottom, 30)
        }
    }
    
    struct Question2View: View {
        @Binding var viewModel: FeedbackFormViewModel
        
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
                    
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.gray)
                }
                .padding(.bottom, 30)
        }
    }
    
    struct Question3View: View {
        @Binding var viewModel: FeedbackFormViewModel
        
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
                    
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.gray)
                }
                .padding(.bottom, 30)
            
        }
    }
    
    struct SubmitButtonView: View {
        @Environment(\.dismiss) var dismiss
        var body: some View {
            HStack {
                Spacer()
                
                Button {
                    // Does nothing right now, will later make a network call.
                    dismiss()
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
                }
                
                Spacer()
            }
        }
    }
}

