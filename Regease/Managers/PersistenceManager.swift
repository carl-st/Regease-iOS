//
//  PersistenceManager.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

protocol RegistrationPersistenceProtocol {
    func user() -> User?
    func createOrUpdate<T: Object>(_ object: T)
}

class PersistenceManager: RegistrationPersistenceProtocol {
    static let sharedInstance = PersistenceManager(realm: nil)
    var realm: Realm
    
    init(realm: Realm?) {
        if let realm = realm {
            self.realm = realm
        } else {
            var config = Realm.Configuration(
                schemaVersion: 2,
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 1 {
                        
                    }
            })
            
            config.deleteRealmIfMigrationNeeded = true // TODO: disable and implement proper migrations above
            Realm.Configuration.defaultConfiguration = config
            self.realm = try! Realm()
        }
        
        debugPrint("Realm file path: \(Realm.Configuration.defaultConfiguration.fileURL)")
    }
    
    func createOrUpdate<T: Object>(_ object: T) {
        createOrUpdate(object, realm: realm)
    }
    
    func createOrUpdate<T: Object>(_ array: [T]) {
        createOrUpdate(array, realm: realm)
    }
    
    func createOrUpdate<T: Object>(_ object: T, realm: Realm) {
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    func createOrUpdate<T: Object>(_ array: [T], realm: Realm) {
        try! realm.write {
            realm.add(array, update: true)
        }
    }
    
    func delete(_ realm: Realm) {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func clearUserData() {
        delete(realm)
    }
    
    func user() -> User? {
        return realm.objects(User.self).first
    }
}
