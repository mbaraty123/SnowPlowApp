//
//  Flags.swift
//  SnowPlow
//
//  Created by Michael Baraty on 12/13/18.
//  Copyright © 2018 Baraty Hannibal Enterprises. All rights reserved.
//
import Foundation
import Parse

var global = Global()

class Flags: NSObject {
    
    var flagList: Array = [Dictionary<String, PFGeoPoint>]()
    
    //creates a new flag and sends it to the Parse server
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
            global.addFlag(ObjectId: myFlag.objectId!)
        } catch {
            print("error!")
            //need to add more than this later
        }
    }
    
    //recieves all parse objects from server then returns an array of dictionary objects containing the ObjectID and its assigned PFGeoPoint object
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
            }
            
        } catch {
            print("error!")
            //need to add more than this later
        }
        return flagList
    }
    
    //Marks the flag with the given ObjectID as completed
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
    
    //Marks the flag with the given ObjectID as accepted
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
    
    //Returns the status of the flag with the given ObjectID in the form of a Dictionary object
    //Order of booleans in Dictionary object is [Accepted:Completed]
    func checkStatus(ObjId: String) -> Dictionary<Bool, Bool>{
        let query = PFQuery(className: "Flags")
        var results: Dictionary<Bool, Bool> = [false: false]
        do{
            let object = try query.getObjectWithId(ObjId)
            let completed = object["complete"]
            let accepted = object["accepted"]
            results = [accepted as! Bool: completed as! Bool]
        } catch{
            print("error! CheckCompletion")
        }
        return results
    }
    

    
}
