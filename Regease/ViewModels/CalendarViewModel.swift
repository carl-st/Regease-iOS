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

    init(persistence: PersistenceManager = PersistenceManager.sharedInstance) {

    }
    
    func loadDay(date: NSDate) {
        
    }

}
