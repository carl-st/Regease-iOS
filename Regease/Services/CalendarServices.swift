//
//  CalendarServices.swift
//  Regease
//
//  Created by Karol Stępień on 29.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper

class CalendarServices: Service {
    
    static let sharedInstance = CalendarServices()
    
    override init() {}
    
    enum Path: String {
        case Appointment = "appointment"
    }
    
    
}
