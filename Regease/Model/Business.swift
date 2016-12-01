//
//  Business.swift
//  Regease
//
//  Created by Karol Stępień on 30.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Business: Object, Mappable {
    dynamic var id = 0
    dynamic var businessDescription = ""
    dynamic var name = ""
    dynamic var email = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        businessDescription <- map["description"]
        name <- map["name"]
        email <- map["email"]
    }
    
}

