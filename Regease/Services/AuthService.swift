//
//  AuthService.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper

class AuthServices: Service {
    
    static let sharedInstance = AuthServices()

    override init() {}
    
    enum Path: String {
        case Login = "login"
    }
    
    
    
}
