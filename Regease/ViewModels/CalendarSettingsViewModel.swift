//
//  CalendarSettingsViewModel.swift
//  Regease
//
//  Created by Karol Stępień on 29.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

class CalendarSettingsViewModel {
    
    var calendar: CalendarSettings?
    var workingDays: [Bool] = [false, false, false, false, false, false, false]
    var workingHoursText = ""
    
    init(persistence: PersistenceManager = PersistenceManager.sharedInstance) {
        calendar = persistence.calendar()
        let workingDaysStringArray = (calendar?.workingDays.characters.split{$0 == ","}.map(String.init))!
        for day in workingDaysStringArray {
            self.workingDays[Int(day)!] = true
        }
        let workingHoursStringArray = (calendar?.workingHours.characters.split{$0 == "-"}.map(String.init))!
        //TODO: fix it!
        self.workingHoursText = "\(workingHoursStringArray[0]):00 - \(workingHoursStringArray[1]):00"
    }
    
}
