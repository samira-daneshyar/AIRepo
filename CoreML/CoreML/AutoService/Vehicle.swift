//
//  Vehicle.swift
//  CoreML
//
//  Created by Zhitao Tian on 5/4/18.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import Foundation
import ObjectMapper

struct VehicleResponse: Mappable {
    var numFound: Int?
    var listings: [Vehicle] = []
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        numFound <- map["num_found"]
        listings <- map["listings"]
    }
}

struct Vehicle: Mappable {
    var id: String?
    var vin: String?
    var heading: String?
    var price: Double?
    var refPrice: Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        vin <- map["vin"]
        heading <- map["heading"]
        price <- map["price"]
        refPrice <- map["ref_price"]
    }
}
