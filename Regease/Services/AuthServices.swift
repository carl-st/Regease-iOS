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
        case Login = "login"
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, Any) -> Void) {
        let parameters: Parameters = ["username": username, "password": password]
        let request = Alamofire.request(Urls.baseUrl + Path.Login.rawValue, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers).validate()
            .responseObject(completionHandler: {
                (response: DataResponse<Token>) in
                switch response.result {
                case .success(let token):
                    print(token)
                    self.persistanceManager.createOrUpdate(token)
                    self.updateHeaders()
//                    self.updateServicesHeaders()
                    completion(true, token)
                case .failure(let error):
                    print(error)
                    completion(false, error)
                }
            })
        print(request)
    }
    
    
    
    
}

