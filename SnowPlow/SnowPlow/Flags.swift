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
    
    var flagList: [Dictionary<GPS, String>] = []
    
    func createFlag(payment: Double, size: Double) {
        let myFlag = PFObject(className: "Flags")
        
        myFlag["GPS"] = [0.0: 0.0]
        myFlag["Payment"] = payment
        myFlag["Size"] = size
        myFlag["complete"] = false
        myFlag["accepted"] = false
        
        
        // Saves the new object.
        myFlag.saveInBackground { (success, error) in
            if (success) {
                print("Success")
            } else {
                print("Error")
            }
        }
       /*     (success: Bool, error: Error?) in
            if (success) {
                print("Success")
            } else {
                print("Error")
            }
        }*/
    }
    
    func receiveFlags() -> [Dictionary<GPS, String>]{
        
        let query = PFQuery(className: "Flags")
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil{
                if let returnedObjects = objects{
                    
                    for object in returnedObjects{
                        let dict = [object["GPS"] as! GPS: object["objectId"] as! String!]
                        self.flagList.append(dict as! [GPS : String])
                    }
                    
                }
            }
        }
        return flagList
    }
    
    func markAsComplete() {
        let query = PFQuery(className: "Flag")
        query.getObjectInBackground(withId: "MYOBJECTID") { (object, error) -> Void in
        if object != nil && error == nil{
            object!["complete"] = true
            object?.saveInBackground()
        //Delete line to be added ehre
        }
        }
    }

    
    
}


