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

class PlowMapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet fileprivate weak var mapView: GMSMapView!

    var locationManager = CLLocationManager()
    var tappedMarker : GMSMarker?
    var customInfoWindow : ViewInfoWindow?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.tappedMarker = GMSMarker()
            self.customInfoWindow = ViewInfoWindow().loadView()
            
            let userLat = locationManager.location?.coordinate.latitude
            let userLong = locationManager.location?.coordinate.longitude
            let camera = GMSCameraPosition.camera(withLatitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681 , zoom: 14)
            mapView.camera = camera
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.settings.compassButton = true
            showMarkers()
            
            //Flags().createFlag(payment: 20.98, size: 400.2)
            //let flagList = Flags().receiveFlags()
            //print(flagList)
        }
    
    func showMarker(position: CLLocationCoordinate2D, title: Double, price: Double, id: String){
        
        let marker = GMSMarker()
        marker.position = position
        marker.title = "\(title) approx. sq. ft."
        marker.snippet = "$\(price)"
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
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return self.customInfoWindow
    }
    
}

    extension PlowMapViewController: GMSMapViewDelegate{
        
        //MARK - GMSMarker Dragging
        func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
            print("didBeginDragging")
        }
        func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
            print("didDrag")
        }
        func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
            print("didEndDragging")
        }
        
        
}
