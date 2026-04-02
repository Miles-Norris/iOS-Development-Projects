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
