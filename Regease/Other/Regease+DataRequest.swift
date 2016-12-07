//
//  Regease+DataRequest.swift
//  Regease
//
//  Created by Karol Stępień on 30.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Alamofire

extension DataRequest {
    
    func completion(completion: @escaping (Bool, Any) -> Void) -> DataRequest {
        return self.responseJSON { response in
            switch response.result {
            case .success(let json):
                completion(true, json)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
        }
    }
    
}
