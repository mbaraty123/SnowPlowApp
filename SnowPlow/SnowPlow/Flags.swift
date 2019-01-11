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
    
    var flagList: Array = [Dictionary<String, PFGeoPoint>]()
    
    func createFlag(payment: Double, size: Double){
        let myFlag = PFObject(className: "Flags")
        
        myFlag["GPS"] = PFGeoPoint(latitude:89.0, longitude:38.0)
        myFlag["Payment"] = payment
        myFlag["Size"] = size
        myFlag["complete"] = false
        myFlag["accepted"] = false
        
        
        // Saves the new object.
        do{
            try myFlag.save()
        } catch {
            print("error!")
            //need to add more than this later
        }
    }
    
    func receiveFlags() -> [Dictionary<String, PFGeoPoint>]{
        print("Called receiveFlags")
        let query = PFQuery(className: "Flags")
        do{
            let queryList = try query.findObjects()
            for object in queryList{
                //let dict = [object.objectId as! String: object["GPS"] as! PFGeoPoint]
                //flagList.append(dict)
                
                self.flagList.append([object.objectId as! String: object["GPS"] as! PFGeoPoint])
                
                print(self.flagList)
                print("Printed flagList")
                //WHY THE HELL DOES FLAGLIST EXIST HERE, BUT CLEARS ITSELF WHEN RETURNED????
                //Everything else works, GPS class needs rework.
            }

        } catch {
            print("error!")
            //need to add more than this later
        }
        print("no error code; proceeding")
        print(flagList)
        print("Printed flaglist inside of Recieveflags")
        return flagList
                        }

    
    func markAsComplete() {
        let query = PFQuery(className: "Flag")
        query.getObjectInBackground(withId: "MYOBJECTID") { (object, error) -> Void in
            if object != nil && error == nil{
                object!["complete"] = true
                object?.saveInBackground()
                //Delete line to be added ehre?
            }
        }
    }
    
    
    
}
