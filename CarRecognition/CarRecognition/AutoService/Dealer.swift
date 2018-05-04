//
//  Dealer.swift
//  CarRecognition
//
//  Created by Zhitao Tian on 5/4/18.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import Foundation
import ObjectMapper

struct Dealer: Mappable {
    var id: String?
    var name: String?
    var street: String?
    var city: String?
    var state: String?
    var zip: String?
    var latitude: String?
    var longtitude: String?
    var phone: String?
    var dealerType: String?
    var rating: Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["map"]
        street      <- map["street"]
        city        <- map["city"]
        state       <- map["state"]
        zip         <- map["zip"]
        latitude    <- map["latitude"]
        longtitude  <- map["longtitude"]
        phone       <- map["phone"]
        dealerType  <- map["dealer_type"]
        rating      <- map["rating"]
    }
}
