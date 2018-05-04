//
//  AutoAPI.swift
//  CoreML
//
//  Created by Zhitao Tian on 5/4/18.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

struct AutoAPI {
    struct APIConsole {
        static let baseURL  = "https://marketcheck-prod.apigee.net/v1/"
        static let appID    = "e3a7e4f6-7805-4059-aa0f-4dc020219e78"
        static let apiKey   = "OY2rEn4xJ2Wo9TPDf5q8eK2ub0sJ3EHo"
    }
    
    static func findDealersNearby(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance = 5000) {
        let url = APIConsole.baseURL + "dealers"
    }
    
    fileprivate static func authenticate(params: Parameters?) -> Parameters {
        var authParams = ["api_key": APIConsole.apiKey]
        
        return authParams
    }
}
