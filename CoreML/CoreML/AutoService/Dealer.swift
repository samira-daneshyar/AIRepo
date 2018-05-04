//
//  Dealer.swift
//  CoreML
//
//  Created by Zhitao Tian on 5/4/18.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import Foundation
import ObjectMapper

struct Dealer: Mappable {
    var id: String?
    var sellerName: String?
    var street: String?
    var city: String?
    var state: String?
    var country: String?
    var zip: String?
    var latitude: String?
    var longitude: String?
    var sellerPhone: String?
    var distance: Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        sellerName  <- map["seller_name"]
        street      <- map["street"]
        city        <- map["city"]
        state       <- map["state"]
        country     <- map["country"]
        zip         <- map["zip"]
        latitude    <- map["latitude"]
        longitude   <- map["longitude"]
        sellerPhone <- map["seller_phone"]
        distance    <- map["distance"]
    }
}
