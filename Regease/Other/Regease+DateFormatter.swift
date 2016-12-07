//
//  Regease+DateFormatter.swift
//  Regease
//
//  Created by Karol Stępień on 04.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation

extension DateFormatter {
    @nonobjc static let dateTimeWithSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        return formatter
    }()
    
    @nonobjc static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
}
