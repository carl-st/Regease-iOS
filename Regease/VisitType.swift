//
//  VisitType.swift
//  Regease
//
//  Created by Karol Stępień on 30.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import ObjectMapper
import RealmSwift

class VisitType: Object, Mappable {
    dynamic var id = ""
    dynamic var typeDescription = ""
    dynamic var name = ""
    dynamic var duration = 0
    dynamic var business: Business?

    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        typeDescription <- map["description"]
        name <- map["name"]
        duration <- map["duration"]
        business <- map["business"]
    }
    
}
