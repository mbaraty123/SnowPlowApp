//
//  GPS.swift
//  SnowPlow
//
//  Created by Michael Baraty on 1/8/19.
//  Copyright © 2019 Baraty Hannibal Enterprises. All rights reserved.
//

import Foundation

struct GPS: Hashable {
    let lat: Double?
    let long: Double?
    
    init(latitude: Double, longitude: Double) {
        self.lat = latitude
        self.long = longitude
    }
}
