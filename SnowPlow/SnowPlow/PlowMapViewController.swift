//
//  PlowMapViewController.swift
//  SnowPlow
//
//  Created by Michael Baraty on 12/12/18.
//  Copyright © 2018 Baraty Hannibal Enterprises. All rights reserved.
//

import UIKit
import GoogleMaps
import Parse

class PlowMapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet fileprivate weak var mapView: GMSMapView!

    var locationManager = CLLocationManager()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            mapView.delegate = self
            
            let userLat = locationManager.location?.coordinate.latitude
            let userLong = locationManager.location?.coordinate.longitude
            let camera = GMSCameraPosition.camera(withLatitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681 , zoom: 14)
            mapView.camera = camera
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.settings.compassButton = true
            
            updateUI()
           
        }
    
    func updateUI() {
        showMarkers()
    }
    
    func showMarker(position: CLLocationCoordinate2D, title: Double, price: Double, id: String){
        
        let marker = GMSMarker()
        marker.position = position
        marker.title = "\(title) approx. sq. ft. for $\(price)"
        marker.snippet = id
        marker.map = mapView
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.2)
        }
    
    
    func showMarkers() {
        let flagList = Flags().receiveFlags()
        print(flagList)
        print("printed flaglist inside of PMVC!")
        
        
        for dict in flagList {
            for item in dict.keys{
                let coord = GPS().PFGeotoClLocation(location: dict[item]!)
                
                let query = PFQuery(className: "Flags")
                do{
                    let object = try query.getObjectWithId(item)
                    if (object["accepted"] as! Bool == false) {
                        showMarker(position: coord, title: object["Size"] as! Double, price: object["Payment"] as! Double, id: object.objectId!)
                    }
                } catch {
                    print("error!")
                    //need to add more than this later
                }
                
                
                print("Dict item \(coord)")
            }
        }
        print("Complete!")
    }
    
}

extension PlowMapViewController {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("info window was tapped")
        global.setObjIDJob(id: marker.snippet!)
        performSegue(withIdentifier: "PlowMapToComplete", sender: nil)
    }
    
}
