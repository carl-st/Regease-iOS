//
//  Regease+NSDate.swift
//  Regease
//
//  Created by Karol Stępień on 04.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation

extension NSDate {
    
    var startOfDay: Date {
        return NSCalendar.current.startOfDay(for: self as Date)
        
    }
    
    var endOfDay: NSDate? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let end = NSCalendar.current.date(byAdding: components, to: startOfDay)!
        return end as NSDate
    }
    
    /// Prints a string representation for the date with the given formatter
    func string(with format: DateFormatter) -> String {
        return format.string(from: self as Date)
    }
    
    /// Creates an `NSDate` from the given string and formatter. Nil if the string couldn't be parsed
    convenience init?(string: String, formatter: DateFormatter) {
        guard let date = formatter.date(from: string) else { return nil }
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }
    
}
