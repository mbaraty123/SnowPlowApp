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
import os.log

class Global: NSObject, NSCoding{
    var jobLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var myFlags: [String]
    var objIDJob: String = ""
    
    struct PropertyKey {
        static let myFlags: Array = [String]
    }
    
    override init() {
        self.myFlags = loadFlags()!
        //myLocation?
    }
    
    func addFlag(ObjectId: String){
        self.myFlags.append(ObjectId)
        saveFlags()
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
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(myFlags, forKey: PropertyKey.myFlags)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.myFlags) as? String else {
            os_log("Unable to decode the name for a objectId.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("myFlags")
    
    private func saveFlags() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(myFlags, toFile: myFlags.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Flags successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save Flags...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadFlags() -> [String]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: myFlags.ArchiveURL.path) as? [String]
    }
    
    func setObjIDJob(id: String) {
        self.objIDJob = id
    }
    
}
