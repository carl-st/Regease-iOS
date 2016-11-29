//
//  Token.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Token: Object, Mappable {
    dynamic var id = 0
    dynamic var accessToken = ""
    dynamic var refreshToken = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        refreshToken <- map["refresh_token"]
    }
    
}
