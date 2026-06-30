//
//  CalendarEntrySubview.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct CalendarEntrySubview: View {
    @Environment(\.colorScheme) var colorScheme
    let calendarEntry: CalendarEntry
    
    private var isToday: Bool {
        let now = Date()
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.locale = Locale.current
        weekdayFormatter.dateFormat = "MMM"
        let dayFormatter = DateFormatter()
        dayFormatter.locale = Locale.current
        dayFormatter.dateFormat = "dd"

        let todayWeek = weekdayFormatter.string(from: now).uppercased()
        let todayDay = dayFormatter.string(from: now)

        let entryWeek = String(calendarEntry.date.prefix(3)).uppercased()
        let entryDay = String(calendarEntry.date.suffix(2))

        return todayWeek == entryWeek && todayDay == entryDay
    }
    
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                .fill(Color.accentColor.opacity(0.9))
                .frame(width: 4)

            VStack(alignment: .center, spacing: 2) {
                Text(calendarEntry.date.suffix(2))
                    .font(.system(size: 40, weight: .semibold, design: .default))
                    .monospacedDigit()
                Text(calendarEntry.date.prefix(3).uppercased())
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .tracking(1)
            }
            .frame(width: 64)

            Divider()
                .frame(height: 56)
                .overlay(Color.secondary.opacity(0.2))
                .padding(.horizontal, 4)

            VStack(alignment: .leading, spacing: 6) {
                if let id = calendarEntry.dayID, let lessonName = calendarEntry.lessonName {
                    Text(lessonName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    Text(id)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } else {
                    Text(calendarEntry.holiday ? "Holiday" : "Weekend")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primary)
                    Text("N/A")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(14)
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .background(
            Group {
                if isToday {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.accentColor.opacity(colorScheme == .dark ? 0.25 : 0.18))
                } else {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.ultraThinMaterial)
                }
            }
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(
                    isToday ? Color.accentColor.opacity(colorScheme == .dark ? 0.9 : 0.7) : Color.black.opacity(colorScheme == .dark ? 0.25 : 0.08),
                    lineWidth: isToday ? 1.0 : 0.5
                )
        )
        .shadow(color: (isToday ? Color.accentColor.opacity(colorScheme == .dark ? 0.6 : 0.35) : Color.black.opacity(colorScheme == .dark ? 0.35 : 0.08)), radius: isToday ? 12 : 10, x: 0, y: isToday ? 8 : 6)
        .frame(minWidth: 350)
        .frame(maxWidth: 350)
        .padding(.bottom, 8)
    }
}

