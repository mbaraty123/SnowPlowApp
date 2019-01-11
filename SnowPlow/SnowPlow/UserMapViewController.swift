//
//  UserMapViewController.swift
//  
//
//  Created by Michael Baraty on 12/12/18.
//

import UIKit
import GoogleMaps
import Parse

class UserMapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userLat = locationManager.location?.coordinate.latitude
        let userLong = locationManager.location?.coordinate.longitude
        let camera = GMSCameraPosition.camera(withLatitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681 , zoom: 17)
        mapView?.camera = camera
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
        
        
        //Flags().createFlag(payment: 20.98, size: 400.2)
        //let flagList = Flags().receiveFlags()
        //print(flagList)
    }
    
    
    
    func showMarker(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let marker = GMSMarker()
        let position = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        marker.position = position
        marker.map = mapView
        marker.isDraggable = true
    }
}
