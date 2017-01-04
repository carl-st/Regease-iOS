//
//  CalendarViewModel.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation

class CalendarViewModel {

    var events: [Appointment] = []
    var persistence = PersistenceManager.sharedInstance

    init(persistence: PersistenceManager = PersistenceManager.sharedInstance) {
        loadDay(date: NSDate())
    }
    
    func loadDay(date: NSDate) {
        events = Array(persistence.appointments(forDate: date))
    }

}
