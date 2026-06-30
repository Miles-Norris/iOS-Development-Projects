//
//  isoDateFormatter.swift
//  Calendar
//
//  Created by Miles Norris on 6/23/26.
//

import Foundation

func formatMonthDay(from isoString: String) -> String? {
    // Parse ISO 8601 string to Date
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // include if your string has fractions
    let date = isoFormatter.date(from: isoString)
        ?? ISO8601DateFormatter().date(from: isoString) // fallback if no fractional seconds
    
    guard let date else { return nil }
    
    // Format Date to "MMM dd" (e.g., "Jan 05")
    let out = DateFormatter()
    out.locale = Locale(identifier: "en_US_POSIX") // stable month abbreviations
    out.timeZone = TimeZone(secondsFromGMT: 0)     // interpret Z as UTC
    out.dateFormat = "MMM dd"
    return out.string(from: date)
}
