//
//  AuthServices.swift
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
        case Login = "auth/login"
        case Logout = "auth/logout"
        case Me = "auth/me"
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, Any) -> Void) {
        let parameters: Parameters = ["username": username, "password": password, "grant_type":"password", "client_id":"1", "client_secret":"abc12345"]
        Alamofire.request(Urls.baseUrl + Path.Login.rawValue, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers).validate()
            .responseObject(completionHandler: {
                (response: DataResponse<Token>) in
                switch response.result {
                case .success(let token):
                    print(token)
                    self.persistanceManager.createOrUpdate(token)
                    self.updateHeaders()
                    self.updateServiceHeaders()
                    completion(true, token)
                case .failure(let error):
                    print(error)
                    completion(false, error)
                }
            })
    }
    
    func refreshToken(user: User, token: Token, completion: @escaping (Bool, Any) -> Void) {
        let parameters: Parameters = ["username": user.username, "refresh_token": token.refreshToken, "grant_type":"refresh_token", "client_id":"1", "client_secret":"abc12345"]
        Alamofire.request(Urls.baseUrl + Path.Login.rawValue, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers).validate()
            .responseObject(completionHandler: {
                (response: DataResponse<Token>) in
                switch response.result {
                case .success(let token):
                    print(token)
                    self.persistanceManager.createOrUpdate(token)
                    self.updateHeaders()
                    self.updateServiceHeaders()
                    completion(true, token)
                case .failure(let error):
                    print(error)
                    completion(false, error)
                }
            })
    }
    
    func me(completion: @escaping (Bool, Any) -> Void) {
        Alamofire.request(Urls.baseUrl + Path.Me.rawValue, method: .get, parameters: nil, headers: self.headers).validate()
            .responseObject(completionHandler: {
                (response: DataResponse<User>) in
                switch response.result {
                case .success(let user):
                    print(user)
                    self.persistanceManager.createOrUpdate(user)
                    completion(true, user)
                case .failure(let error):
                    print(error)
                    if error is AFError {
                        switch response.result.error as! AFError {
                        case .responseValidationFailed(let reason):
                            switch reason {
                            case .unacceptableStatusCode(let code):
                                completion(false, code)
                            default:
                                completion(false, error)
                            }
                        default:
                            completion(false, error)
                        }
                    } else {
                        completion(false, error)
                    }
                }
            })
    }
    
    func logout(completion: @escaping (Bool, Any) -> Void) {
        Alamofire.request(Urls.baseUrl + Path.Logout.rawValue, method: .post, parameters: nil, headers: self.headers).validate()
            .completion(completion: completion)
    }
    
    func updateServiceHeaders() {
        CalendarServices.sharedInstance.headers = self.headers
    }
    
}

