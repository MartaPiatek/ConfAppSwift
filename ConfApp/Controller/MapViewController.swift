//
//  MapViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 30.05.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import UberRides
import CoreLocation
import Alamofire
import SwiftyJSON

enum Location {
    case startLocation
    case destinationLocation
}


class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var googleMaps: GMSMapView!
    
    @IBOutlet weak var distanceL: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var planButton: UIButton!
    
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assignbackground()

        self.planButton.alignTextBelow(spacing: 6.0)
        self.routeButton.alignTextBelow(spacing: 6.0)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        self.view.addSubview(planButton)
        self.view.addSubview(routeButton)
        self.view.addSubview(distanceLabel)
       self.view.addSubview(distanceL)
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
      //  let camera = GMSCameraPosition.camera(withLatitude: 51.146357, longitude: 17.070894, zoom: 15.0)
        
        
        
        let currentLocation: CLLocation!
         currentLocation = locationManager.location
        
        let camera = GMSCameraPosition.camera(withLatitude:  currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 15.0)
       
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
 
        let markerMyLocation = GMSMarker()
        markerMyLocation.position = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        markerMyLocation.title = "I am here"
        markerMyLocation.map = googleMaps
        
        let markerPwr = GMSMarker()
        markerPwr.position = CLLocationCoordinate2D(latitude: 51.107852, longitude: 17.061777)
        markerPwr.title = "Wroclaw Univerity of Science and Techonology"
        markerPwr.map = googleMaps
        

        
    
        /*
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        
        let button = RideRequestButton()
       
        
        let dropoffLocation = CLLocation(latitude: 51.107852, longitude: 17.061777)
        let builder = RideParametersBuilder()
        builder.dropoffLocation = dropoffLocation
        builder.dropoffNickname = "Politechnika Wrocławska"
        button.rideParameters = builder.build()
        
         button.center = view.center
        
        button.colorStyle = .white
        view.addSubview(button)
   */
    
    }
    
    func createMarker(titleMarker: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.map = googleMaps
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
                let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        let locationPwr = CLLocation(latitude: 51.107852, longitude: 17.061777)
        
        
   //     createMarker(titleMarker: "Politecznika Wrocławska" , latitude: locationPwr.coordinate.latitude, longitude: locationPwr.coordinate.longitude)
        
   //     createMarker(titleMarker: "Tu jestem", latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
        drawPath(startLocation: location!, endLocation: locationPwr)
        
            
        let distance = location!.distance(from: locationPwr)
      
        print("DISTANCE \(distance)")
        distanceL.text = "Distance"
        distanceLabel.text = String((distance/1000 * 100).rounded() / 100) + " km"
        
                self.googleMaps?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMaps.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMaps.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMaps.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    
    
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation){
        
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)
            print(response.response as Any)
            print(response.data as Any)
            print(response.result as Any)
        
           do {
            
            let json = try JSON(data: response.data!)
        
            
            let routes = json["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor(red: 242.0/255, green: 78.0/255, blue: 134.0/255, alpha: 1.0)
                polyline.map = self.googleMaps
            }
            
            let distance = startLocation.distance(from: endLocation)
            
            self.distanceLabel.text = String((distance/1000 * 100).rounded() / 100) + " km"
            
          
            
            
           }
           catch {
               print(error)
           }
        }
    }
    
    @IBAction func showDirection(_ sender: UIButton){
        
        var currentLocation: CLLocation!
      //  var loc = CLLocation(latitude: 51.115582, longitude: 17.067350)
        currentLocation = locationManager.location
        
        self.drawPath(startLocation: currentLocation, endLocation: CLLocation(latitude: 51.107852, longitude: 17.061777))
        
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func assignbackground(){
        let background = UIImage(named: "background2")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.alpha = 0.55
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    

}


