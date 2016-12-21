//
//  DashboardViewModel.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation
import RealmSwift

class DashboardViewModel {

    var appointmentsNotificationToken: NotificationToken? = nil
    var persistenceManager: PersistenceManager
    var reload: (() -> Void)?
    
    var user: User = User()
    var appointments: [Appointment] = []
    
    init(reload: (() -> Void)? = nil, persistence: PersistenceManager = PersistenceManager.sharedInstance) {
        self.reload = reload
        self.persistenceManager = persistence
        
        self.user = persistence.user()!
        self.appointments = Array(persistence.appointments(forDate: NSDate()))
        
        let realm = try! Realm()
        let results = realm.objects(Appointment.self)
        appointmentsNotificationToken = results.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let reload = reload else {
                return
            }
            switch changes {
            case .initial:
                break
            case .update(_, _, _, _):
                self?.appointments = Array(persistence.appointments(forDate: NSDate()))
                reload()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    deinit {
        appointmentsNotificationToken?.stop()
    }
    
}
