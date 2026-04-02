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
                Markdown(lessonOutline.lessonMarkdown)
                    .markdownTheme(.gitHub)
                    .padding()
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

#Preview {
    LessonOutlineView(lessonOutline: LessonOutline.lessonOutlines["Strings"]!)
}
