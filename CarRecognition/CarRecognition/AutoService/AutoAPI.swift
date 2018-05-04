//
//  AutoAPI.swift
//  CarRecognition
//
//  Created by Zhitao Tian on 5/4/18.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import AlamofireObjectMapper

struct AutoAPI {
    struct APIConsole {
        static let baseURL  = "https://marketcheck-prod.apigee.net/v1/"
        static let appID    = "e3a7e4f6-7805-4059-aa0f-4dc020219e78"
        static let apiKey   = "OY2rEn4xJ2Wo9TPDf5q8eK2ub0sJ3EHo"
    }
    
    static func findDealersNearby(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance = 5000, onSuccess: (([Dealer]) -> Void)?, onFailure: ((Error) -> Void)?) {
        let url = APIConsole.baseURL + "dealers"
        let params = authenticate(params: ["latitude": coordinate.latitude,
                                           "longitude": coordinate.longitude,
                                           "radius": radius])
        
        Alamofire.request(url, parameters: params).responseArray { (response: DataResponse<[Dealer]>) in
            switch response.result {
            case .success(let dealers):
                onSuccess?(dealers)
            case .failure(let error):
                onFailure?(error)
            }
        }
    }
    
    fileprivate static func authenticate(params: Parameters?) -> Parameters {
        if var params = params {
            params["api_key"] = APIConsole.apiKey
            return params
        }
        
        return ["api_key": APIConsole.apiKey]
    }
}
