//
//  ApearanceSettingsViewModel.swift
//  Regease
//
//  Created by Karol Stępień on 08.01.2017.
//  Copyright © 2017 Regease. All rights reserved.
//

import Foundation

class AppearanceSettingsViewModel {
    
    var calendar: CalendarSettings?
    var titleText = ""
    var descriptionText = ""
    var primaryColorText = ""
    var accentColorText = ""
    var visibility: Bool = false
    
    init(persistence: PersistenceManager = PersistenceManager.sharedInstance) {
        calendar = persistence.calendar()
        if let calendar = calendar {
            self.titleText = calendar.title
            self.descriptionText = calendar.description
            self.visibility = calendar.visibleTitle
            self.primaryColorText = calendar.primaryColor
            self.accentColorText = calendar.accentColor
        }
    }
    
}
