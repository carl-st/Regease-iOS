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

    func createOrUpdateAndRemoveDeleted<T: Object>(_ array: [T]) {
        realm.beginWrite()
        realm.delete(realm.objects(Appointment.self))
        try! realm.commitWrite()
        createOrUpdate(array, realm: realm)
//        realm.beginWrite()
//        let oldIds: NSMutableArray = realm.objects(Appointment.self).value(forKeyPath: "id") as! NSMutableArray
//        for object in array {
//            oldIds.remove(object.value(forKeyPath: "id")!)
//        }
//        let oldObjects = realm.objects(T.self).filter("id IN %@", oldIds)
//        print("Old objects: \(oldObjects)")
//        realm.delete(oldObjects)
//        try! realm.commitWrite()
    }

    func visitType(forId id: String) -> VisitType? {
        return realm.object(ofType: VisitType.self, forPrimaryKey: id)
    }
    
    func appointments() -> Results<Appointment> {
        return realm.objects(Appointment.self)
    }
    
    func appointments(forDate date: NSDate) -> Results<Appointment> {
        return realm.objects(Appointment.self).filter("date > %@ && date <= %@", date, date.endOfDay!)
    }
    
    func calendar() -> CalendarSettings? {
        return realm.objects(CalendarSettings.self).first
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
    
    func registrant(forId id: String) -> Registrant? {
        return realm.object(ofType: Registrant.self, forPrimaryKey: id)
    }
}
