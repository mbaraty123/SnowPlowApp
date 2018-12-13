//
//  Flags.swift
//  SnowPlow
//
//  Created by Michael Baraty on 12/13/18.
//  Copyright © 2018 Baraty Hannibal Enterprises. All rights reserved.
//

import Foundation
import Parse

class Flags: NSObject {

    var parseObject = PFObject(className: "Flags")
    
    parseObject["GPS"] = [ "foo": "bar" ]
    parseObject["Payment"] = 1
    parseObject["Size"] = 1

    // Saves the new object.
    parseObject.saveInBackground {
        (success: Bool, error: Error?) in
        if (success) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }

}
