//
//  CalendarView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct CalendarView: View {
    @State var viewModel: CalendarViewModel
    // To display all of our lessons, it uses a subview for each course of the program that displays all the lessons in that course
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(CalendarEntry.sections, id: \.self) { section in
                        CalendarSectionSubview(section: viewModel.sectionData[section] ?? CalendarEntry.swiftFundamentals, sectionTitle: section)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    CalendarView(viewModel: CalendarViewModel())
}
