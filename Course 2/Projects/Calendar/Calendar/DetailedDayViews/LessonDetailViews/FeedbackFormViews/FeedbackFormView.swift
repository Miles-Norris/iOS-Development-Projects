//
//  FeedbackFormView.swift
//  Calendar
//
//  Created by Miles Norris on 4/2/26.
//

import SwiftUI

struct FeedbackFormView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel = FeedbackFormViewModel()
    var body: some View {
        // There a two views in the feedback form, one to select a lesson to give feedback on, and one to fill out the form. They both use the same viewModel.
        if viewModel.selectedLesson == nil {
            FeedbackFormSelectView(viewModel: $viewModel)
        } else {
            FeedbackFormSubmitView(viewModel: $viewModel)
        }
    }
}

#Preview {
    FeedbackFormView()
}
