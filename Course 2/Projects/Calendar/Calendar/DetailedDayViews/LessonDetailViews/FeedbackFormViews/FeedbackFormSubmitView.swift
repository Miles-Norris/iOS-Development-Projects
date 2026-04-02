//
//  FeedbackFormSubmitView.swift
//  Calendar
//
//  Created by Miles Norris on 4/2/26.
//

import SwiftUI

struct FeedbackFormSubmitView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var viewModel: FeedbackFormViewModel
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
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
                    .padding(.bottom, 30)
                
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
                    .padding(.bottom, 30)
                
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
                    .padding(.bottom, 30)
                
                HStack {
                    Spacer()
                    
                    Button {
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
}

