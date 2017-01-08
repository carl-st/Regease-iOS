//
//  CalendarSettingsViewModel.swift
//  Regease
//
//  Created by Karol Stępień on 29.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class CalendarSettingsViewModel {
    
    var calendar: CalendarSettings?
    var modifications: CalendarSettings?
    var startingHour = 0
    var endingHour = 0
    var workingDays: [Bool] = [false, false, false, false, false, false, false]
    var workingHoursText = ""
    
    init(persistence: PersistenceManager = PersistenceManager.sharedInstance) {
        calendar = persistence.calendar()
        
        persistence.realm.beginWrite()
            let calendarJSON = Mapper().toJSON(calendar!)
            self.modifications = Mapper().map(JSON: calendarJSON)
        try! persistence.realm.commitWrite()
        
        let workingDaysStringArray = (calendar?.workingDays.characters.split{$0 == ","}.map(String.init))!
        for day in workingDaysStringArray {
            self.workingDays[Int(day)!] = true
        }
        let workingHoursStringArray = (calendar?.workingHours.characters.split{$0 == "-"}.map(String.init))!
        // TODO: fix it!
        self.workingHoursText = "\(workingHoursStringArray[0]):00 - \(workingHoursStringArray[1]):00"
        self.startingHour = Int(workingHoursStringArray[0])!
        self.endingHour = Int(workingHoursStringArray[1])!
    }
    
    func setWorkingTimeSettings() {
        modifications?.workingDays = ""
        for i: Int in 0 ..< workingDays.count {
            if workingDays[i] == true {
                i == 0 || modifications?.workingDays == "" ? (modifications?.workingDays += "\(i)") : (modifications?.workingDays += ",\(i)")
            }
        }
        modifications?.workingHours = "\(startingHour)-\(endingHour)"
        self.workingHoursText = "\(startingHour):00 - \(endingHour):00"
    }
    
}
