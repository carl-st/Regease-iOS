//
//  Calendar.swift
//  Regease
//
//  Created by Karol Stępień on 19.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import RealmSwift
import ObjectMapper

class CalendarSettings: Object, Mappable {
    dynamic var id = ""
    dynamic var business: Business?
    dynamic var title = ""
    dynamic var calendarDescription = ""
    dynamic var workingDays = ""
    dynamic var workingHours = ""
    dynamic var primaryColor = ""
    dynamic var accentColor = ""
    dynamic var warnColor = ""
    dynamic var visibleTitle = false
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        calendarDescription <- map["description"]
        title <- map["title"]
        business <- map["business"]
        workingDays <- map["workingDays"]
        workingHours <- map["workingHours"]
        primaryColor <- map["primaryColor"]
        accentColor <- map["accentColor"]
        warnColor <- map["warnColor"]
        visibleTitle <- map["visibleTitle"]
    }
    
}

