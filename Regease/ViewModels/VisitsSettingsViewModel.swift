//
//  VisitsSettingsViewModel.swift
//  Regease
//
//  Created by Karol Stępień on 29.12.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import RealmSwift

class VisitsSettingsViewModel {
    
    var visitTypes: [VisitType] = []
    
    init(persistence: PersistenceManager = PersistenceManager.sharedInstance) {
        visitTypes = Array(PersistenceManager.sharedInstance.visitTypes())
    }
    
}
