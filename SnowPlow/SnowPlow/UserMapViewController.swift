//
//  UserMapViewController.swift
//  
//
//  Created by Michael Baraty on 12/12/18.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Parse

class UserMapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    @IBOutlet weak var textField: UITextField!
    
    var marker = GMSMarker()
    var locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    //segues to the table view controller showing users' past requests
    @IBAction func seeRequestsButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "MapToRequests", sender: nil)
    }
    
    //prepares for and performs segue to the form
    @IBAction func selectLocationButtonTapped(_ sender: UIBarButtonItem) {
        global.setLocation(location: marker.position)
        print(global.jobLocation)
        performSegue(withIdentifier: "UserMapToForm", sender: nil)
        print("button worked")
    }
    
    // Present the Autocomplete view controller when the textField is tapped.
    @IBAction func textFieldTapped(_ sender: UITextField) {
        textField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self as GMSAutocompleteViewControllerDelegate
        present(acController, animated: true, completion: nil)
    }
    
    @IBAction func textFieldDone(_ sender: UITextField!) {
        //Could not get geocoder to work, so just says error
        textField.text = "ERROR"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initiates the mapView
        let userLat = locationManager.location?.coordinate.latitude
        let userLong = locationManager.location?.coordinate.longitude
        let camera = GMSCameraPosition.camera(withLatitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681 , zoom: 18)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        //Sets up the marker where the user can specify the location
        marker.position = CLLocationCoordinate2D(latitude: userLat ?? 42.581343, longitude: userLong ?? -70.952681)
        marker.map = mapView
        marker.isDraggable = true
        
    }
}
//More work on setting up the geocoder. This specific part is for the autocomplete search bar, from which the coordinates would be derived. Borrowed from the Google AutoCompletion tutorial
extension UserMapViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        textField.text = place.name
        // Dismiss the GMSAutocompleteViewController when something is selected
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
    
   
}

