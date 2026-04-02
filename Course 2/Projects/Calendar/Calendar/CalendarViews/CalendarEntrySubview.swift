//
//  CalendarEntrySubview.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct CalendarEntrySubview: View {
    let calendarEntry: CalendarEntry
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 0) {
                Text(calendarEntry.date.suffix(2))
                    .font(.system(size: 45))
                    .bold()
                Text(calendarEntry.date.prefix(3))
                    .font(.system(size: 20))
                    .bold()
            }
            
            Divider()
                .frame(width: 20, height: 75)
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(calendarEntry.lessonID)
                    .font(.system(size: 15))
                    .bold()
                
                Text(calendarEntry.lessonName)
                    .font(.system(size: 20))
                    .bold()
            }
            
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.white)
                .shadow(radius: 10)
        }
        .frame(minWidth: 365)
        .frame(maxWidth: 365)
        .padding(.bottom, 10)
    }
}

#Preview {
    CalendarEntrySubview(calendarEntry: CalendarEntry.calendarEntrys[2])
}
