//
//  Service.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper

class Service {
    var persistanceManager = PersistenceManager.sharedInstance
    var headers: HTTPHeaders = [:]
    
    init() {
        self.headers = [
            "Content-Type": "application/json",
//            "Accept": "application/json"
        ]
        
        updateHeaders()
    }
    
    func updateHeaders() -> Void {
        if let token = persistanceManager.realm.objects(Token.self).first {
            self.headers["Authorization"] = "Bearer \(token.accessToken)"
        }

    }
    
}
