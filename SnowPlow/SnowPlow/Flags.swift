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
    
    func createFlag(payment: Double, size: Double, location: CLLocationCoordinate2D){
        let myFlag = PFObject(className: "Flags")
        
        myFlag["GPS"] = GPS().CLlocationtoPFGeo(location: location)
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
        return flagList
    }
    
    
    func markAsComplete(objid: String) {
        let query = PFQuery(className: "Flags")
        
        do{
            let object = try query.getObjectWithId(objid)
            object["complete"] = true
            do{
                try object.save()
            } catch {
                print("error! markascomplete save")
                //need to add more than this later
            }
        } catch {
            print("error! Markascomplete get")
            //need to add more than this later
        }
    }
    
    func markAsAccepted(objid: String) {
        let query = PFQuery(className: "Flags")
        
        do{
            let object = try query.getObjectWithId(objid)
            object["accepted"] = true
            do{
                try object.save()
            } catch {
                print("error! markasaccept save")
                print(error)
                //need to add more than this later
            }
        } catch {
            print("error! Markasaccept get")
            //need to add more than this later
        }
    }
    
    
    
}
