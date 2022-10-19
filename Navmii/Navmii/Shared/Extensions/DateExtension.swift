//
//  DateExtension.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import Foundation

extension Date {

    static let standardDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter
    }()
    
    static let createdAtDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy "
        return formatter
    }()
    
    var createdAtDateString: String {
        Date.createdAtDateFormatter.string(from: self)
    }
}

