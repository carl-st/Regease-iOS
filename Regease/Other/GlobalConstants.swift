//
//  GlobalConstants.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation

struct Urls {
    #if LOCAL
    static var baseUrl = "http://injected:8080/api/" // See build phases > "Inject local ip" script
    #elseif PRODUCTION
    static var baseUrl = "http://injected:8080/api/" // TODO: Set proper AWS IPs
    #else
    static var baseUrl = "http://injected:8080/api/"
    #endif
}

struct Settings {
    static var WorkingHours = "WorkingHours"
    static var WorkingDays = "WorkingDays"
}
