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
    var marker = GMSMarker()
    var locationManager = CLLocationManager()
    
    @IBAction func seeRequestsButtonTapped(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "MapToRequests", sender: nil)
    }
    
    
    @IBAction func selectLocationButtonTapped(_ sender: UIBarButtonItem) {

        global.setLocation(location: marker.position)
        print(global.jobLocation)
        
        
        performSegue(withIdentifier: "UserMapToForm", sender: nil)
                print("button worked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userLat = locationManager.location?.coordinate.latitude
        let userLong = locationManager.location?.coordinate.longitude
        let camera = GMSCameraPosition.camera(withLatitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681 , zoom: 18)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        //self.marker = showMarker(latitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681)
        marker.position = CLLocationCoordinate2D(latitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681)
        marker.map = mapView
        marker.isDraggable = true
        marker.icon = UIImage(named: "userMarkerIcon")
        
        
    }
   // let markerPos = marker.position
    
    
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
