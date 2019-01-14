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
        let camera = GMSCameraPosition.camera(withLatitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681 , zoom: 18)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        let marker = showMarker(latitude: locationManager.location?.coordinate.latitude ?? 42.581343, longitude: locationManager.location?.coordinate.longitude ?? -70.952681)
        let markerPos = marker.position
        //Flags().createFlag(payment: 20.98, size: 400.2)
        //let flagList = Flags().receiveFlags()
        //print(flagList)
    }
    
    
    
    func showMarker(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> GMSMarker{
        let marker = GMSMarker()
        let position = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        marker.position = position
        marker.map = mapView
        marker.isDraggable = true
        marker.icon = UIImage(named: "userMarkerIcon")
        
        return marker
    }
}
