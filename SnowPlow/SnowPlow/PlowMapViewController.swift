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
    
        override func viewDidLoad() {
            super.viewDidLoad()
            let userLat = locationManager.location?.coordinate.latitude
            let userLong = locationManager.location?.coordinate.longitude
            let camera = GMSCameraPosition.camera(withLatitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681 , zoom: 14)
            mapView.camera = camera
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            showMarkers()
            
            //Flags().createFlag(payment: 20.98, size: 400.2)
            //let flagList = Flags().receiveFlags()
            //print(flagList)
        }
    
    
    
    func showMarker(position: CLLocationCoordinate2D, title: String, price: Double){
        let marker = GMSMarker()
        marker.position = position
        marker.title = title
        marker.snippet = "$ \(price)"
        marker.map = mapView
        }
    
    
    func showMarkers() {
        let flagList = Flags().receiveFlags()
        print(flagList)
        print("printed flaglist inside of PMVC!")
        
        
        for dict in flagList {
            for item in dict.keys{
                let coord = GPS().PFGeotoClLocation(location: dict[item]!)
                showMarker(position: coord, title: "TITLE", price: 9.99)
                print("Dict item \(coord)")
            }
        }
        print("Complete!")
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
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
            let marker = GMSMarker()
            marker.position = coordinate
            
        }
}
