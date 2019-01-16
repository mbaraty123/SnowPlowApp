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

class Global: NSObject, NSCoding {
    var jobLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var myFlags: [String] = []
    var objIDJob: String = ""
    
    struct PropertyKey {
        static let id = "ID"
    }

    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("IDs")
    
    static func loadFromFile() -> [String]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Global.ArchiveURL.path) as? [String]
    }
    
    static func saveToFile(flags: [String]) {
        NSKeyedArchiver.archiveRootObject(flags, toFile: Global.ArchiveURL.path)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? String
            else {
                return nil
        }
        
        self.init(coder: aDecoder)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(myFlags, forKey: PropertyKey.id)
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
    
    func setObjIDJob(id: String) {
        self.objIDJob = id
    }
    
    
}


