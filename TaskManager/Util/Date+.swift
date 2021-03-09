//
//  Date+.swift
//  TaskManager
//
//  Created by Milan Kamilya on 09/03/21.
//

import Foundation

enum DateFormat: String {
    case ISO8601 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case EEEE_MM_dd = "EEEE MM/dd"
}

extension Date {
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

    func toString(_ format: DateFormat, dateFormatter: DateFormatter = DateFormatter()) -> String {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    static func getDate(fromString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: fromString)
    }
}
