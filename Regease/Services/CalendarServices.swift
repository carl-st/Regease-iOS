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
        case Setting = "calendar"
    }
    
    func getAppointments(completion: @escaping (Bool, Any) -> Void) {
        Alamofire.request(Urls.baseUrl + Path.Appointment.rawValue, method: .get, parameters: nil, headers: self.headers).validate()
            .responseArray(completionHandler: {
                (response: DataResponse<[Appointment]>) in
                switch response.result {
                case .success(let appointments):
                    print(appointments)
                    // TODO: Find better way
                    let args = ProcessInfo.processInfo.arguments
                    if args.contains("UI_TEST_MODE") {
                        self.persistanceManager.createOrUpdate(appointments)
                    } else {
                        self.persistanceManager.createOrUpdateAndRemoveDeleted(appointments)
                    }
                    completion(true, appointments)
                case .failure(let error):
                    print(error)
                    completion(false, error)
                }
            })
    }
    
    func getCalendar(completion: @escaping (Bool, Any) -> Void) {
        Alamofire.request(Urls.baseUrl + Path.Setting.rawValue, method: .get, parameters: nil, headers: self.headers).validate()
            .responseObject(completionHandler: {
                (response: DataResponse<CalendarSettings>) in
                switch response.result {
                case .success(let setting):
                    print(setting)
                    self.persistanceManager.createOrUpdate(setting)
                    completion(true, setting)
                case .failure(let error):
                    print(error)
                    completion(false, error)
                }
            })
    }
    
    func updateCalendar(calendar: CalendarSettings, completion: @escaping (Bool, Any) -> Void) {
        PersistenceManager.sharedInstance.realm.beginWrite()
        let parameters = Mapper().toJSON(calendar)
        try! PersistenceManager.sharedInstance.realm.commitWrite()
        Alamofire.request(Urls.baseUrl + Path.Setting.rawValue + "?id=\(calendar.id)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers).validate()
            .responseObject(completionHandler: {
                (response: DataResponse<CalendarSettings>) in
                switch response.result {
                case .success(let setting):
                    print(setting)
                    self.persistanceManager.createOrUpdate(setting)
                    completion(true, setting)
                case .failure(let error):
                    print(error)
                    completion(false, error)
                }
            })
    }
    
    func updateAppointment(appointmentId: String, parameters: Parameters, completion: @escaping (Bool, Any) -> Void) {
        Alamofire.request(Urls.baseUrl + Path.Appointment.rawValue + "?id=\(appointmentId)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers).validate()
            .completion(completion: completion)
    }
    
    func cancelAppointment(appointmentId: String, completion: @escaping (Bool, Any) -> Void) {
        let parameters: Parameters = ["id": appointmentId]
        Alamofire.request(Urls.baseUrl + Path.Appointment.rawValue, method: .delete, parameters: parameters, encoding: URLEncoding.default, headers: self.headers).validate()
                .completion(completion: completion)
    }
}
