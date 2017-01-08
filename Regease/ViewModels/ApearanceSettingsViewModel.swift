//
//  ApearanceSettingsViewModel.swift
//  Regease
//
//  Created by Karol Stępień on 08.01.2017.
//  Copyright © 2017 Regease. All rights reserved.
//

import Foundation
import ObjectMapper

class AppearanceSettingsViewModel {
    
    var calendar: CalendarSettings?
    var modifications: CalendarSettings?
    var titleText = ""
    var descriptionText = ""
    var primaryColorText = ""
    var accentColorText = ""
    var warnColorText = ""
    var visibility: Bool = false
    
    init(persistence: PersistenceManager = PersistenceManager.sharedInstance) {
        calendar = persistence.calendar()
        persistence.realm.beginWrite()
        let calendarJSON = Mapper().toJSON(calendar!)
        self.modifications = Mapper().map(JSON: calendarJSON)
        try! persistence.realm.commitWrite()
        if let calendar = calendar {
            self.titleText = calendar.title
            self.descriptionText = calendar.calendarDescription
            self.visibility = calendar.visibleTitle
            self.primaryColorText = calendar.primaryColor
            self.accentColorText = calendar.accentColor
            self.warnColorText = calendar.warnColor
            self.visibility = calendar.visibleTitle
        }
    }
    
}
