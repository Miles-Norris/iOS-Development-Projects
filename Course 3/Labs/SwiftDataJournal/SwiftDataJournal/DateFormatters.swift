//
//  DateFormatters.swift
//  SwiftDataJournal
//
//  Created by Miles Norris on 4/27/26.
//

import Foundation

var relativeDateFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    return formatter
}()

