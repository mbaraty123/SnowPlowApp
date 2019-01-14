//
//  GPS.swift
//  SnowPlow
//
//  Created by Michael Baraty on 1/8/19.
//  Copyright © 2019 Baraty Hannibal Enterprises. All rights reserved.
//

import Foundation
import Parse
import CoreLocation

class GPS {
    
    func CLlocationtoPFGeo(location: CLLocationCoordinate2D) -> PFGeoPoint{
        return PFGeoPoint(latitude: location.latitude, longitude: location.longitude)
    }
    
    func PFGeotoClLocation(location: PFGeoPoint) -> CLLocationCoordinate2D{
        return CLLocationCoordinate2DMake(location.latitude, location.longitude)
    }
    
}

