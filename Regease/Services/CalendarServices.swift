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
        case Setting = "setting"
    }
    
    func getAppointments(completion: @escaping (Bool, Any) -> Void) {
        Alamofire.request(Urls.baseUrl + Path.Appointment.rawValue, method: .get, parameters: nil, headers: self.headers).validate()
            .responseArray(completionHandler: {
                (response: DataResponse<[Appointment]>) in
                switch response.result {
                case .success(let appointments):
                    print(appointments)
                    self.persistanceManager.createOrUpdate(appointments)
                    completion(true, appointments)
                case .failure(let error):
                    print(error)
                    completion(false, error)
                }
            })
    }
    
    func getSetting(forKey key: String, completion: @escaping (Bool, Any) -> Void) {
        Alamofire.request(Urls.baseUrl + Path.Setting.rawValue, method: .get, parameters: ["key": key], headers: self.headers).validate()
            .responseObject(completionHandler: {
                (response: DataResponse<Setting>) in
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
}
