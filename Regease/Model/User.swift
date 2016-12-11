//
//  User.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import RealmSwift
import ObjectMapper

class User: Object, Mappable {
    dynamic var id = 0
    dynamic var username = ""
    dynamic var name = ""
    dynamic var surname = ""
    dynamic var email = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .toJSON {
            var id = self.id
            id <- map["id"]
        }
        else {
            id <- map["id"]
        }
        username <- map["username"]
        name <- map["name"]
        surname <- map["surname"]
        email <- map["email"]
    }
    
    // https://github.com/Hearst-DD/ObjectMapper/issues/340
}
