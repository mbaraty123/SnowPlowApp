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
            let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude: -122.0, zoom: 6.0)
            mapView.camera = camera
            showMarker(position: camera.target)
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            
            Flags().createFlag(payment: 20.98, size: 400.2)
            //let flagList = Flags().receiveFlags()
            //print(flagList)
        }
    
    /*func currentLocation() -> CLLocationCoordinate2D{
        
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }*/
    
    func showMarker(position: CLLocationCoordinate2D){
            let marker = GMSMarker()
            marker.position = position
            
            marker.map = mapView
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
