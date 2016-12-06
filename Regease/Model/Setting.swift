//
//  Setting.swift
//  Regease
//
//  Created by Karol Stępień on 01.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Setting: Object, Mappable {
    dynamic var id = ""
    dynamic var category = SettingCategory.Undefined.rawValue
    dynamic var key = SettingKey.Undefined.rawValue
    dynamic var value = ""
    dynamic var business: Business?
    
    var categoryEnum: SettingCategory {
        get {
            return SettingCategory(rawValue: category)!
        }
        set {
            category = newValue.rawValue
        }
    }
    
    var keyEnum: SettingKey {
        get {
            return SettingKey(rawValue: key)!
        }
        set {
            key = newValue.rawValue
        }
    }
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        category <- map["category"]
        key <- map["key"]
        value <- map["value"]
        business <- map["business"]
    }
    
    enum SettingCategory: String {
        case Appearance
        case Calendar
        case Undefined
    }
    
    enum SettingKey: String {
        case WorkingDays
        case WorkingHours
        case ColorSchema
        case Undefined
    }
    
}

