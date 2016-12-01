//
//  Appointment.swift
//  Regease
//
//  Created by Karol Stępień on 30.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Appointment: Object, Mappable {
    dynamic var id = 0
    dynamic var registrant: Registrant?
    dynamic var date = ""
    dynamic var business: Business?
    dynamic var visitType: VisitType?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        registrant <- map["registrant"]
        date <- map["date"]
        business <- map["business"]
        visitType <- map["visitType"]
    }
    
}
