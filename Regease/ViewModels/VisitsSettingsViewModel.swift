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
    var visitTypesNotificationToken: NotificationToken? = nil
    var persistenceManager: PersistenceManager
    var reload: (() -> Void)?
    
    init(reload: (() -> Void)? = nil, persistence: PersistenceManager = PersistenceManager.sharedInstance) {
        self.reload = reload
        self.persistenceManager = persistence
        
        visitTypes = Array(persistence.visitTypes())
        
        let realm = try! Realm()
        let results = realm.objects(VisitType.self)
        visitTypesNotificationToken = results.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let reload = reload else {
                return
            }
            switch changes {
            case .initial:
                break
            case .update(_, _, _, _):
                self?.visitTypes = Array(persistence.visitTypes())
                reload()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    deinit {
        visitTypesNotificationToken?.stop()
    }

    
}
