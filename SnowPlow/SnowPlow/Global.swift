//
//  Globals.swift
//  SnowPlow
//
//  Created by Michael Baraty on 1/15/19.
//  Copyright © 2019 Baraty Hannibal Enterprises. All rights reserved.
//

import Foundation
import CoreLocation
import Parse

class Global{
    var jobLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var myFlags: [String]
    
    init() {
        self.myFlags = []
        //myLocation?
    }
    
    func addFlag(ObjectId: String){
        self.myFlags.append(ObjectId)
    }
    
    func checkFlags() -> [Dictionary<Bool, Bool>]{
        var statusList: Array = [Dictionary<Bool, Bool>]()
        for ObjId in myFlags{
            statusList.append(Flags().checkStatus(ObjId: ObjId))
            //ORDER IS accepted: completed
        }
        return statusList
    }
    
    func setLocation(location: CLLocationCoordinate2D) {
        self.jobLocation = location
    }
}


