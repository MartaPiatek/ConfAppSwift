//
//  MapViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 30.05.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import GoogleMaps
import UberRides
import CoreLocation


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    private let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        
        let button = RideRequestButton()
       
        
        let dropoffLocation = CLLocation(latitude: 51.108221, longitude: 17.062037)
        let builder = RideParametersBuilder()
        builder.dropoffLocation = dropoffLocation
        builder.dropoffNickname = "Politechnika Wrocławska"
        button.rideParameters = builder.build()
        
         button.center = view.center
        
        button.colorStyle = .white
        view.addSubview(button)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: CLLocationManagerDelegate {
    
    func location (_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
   
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        
        locationManager.stopUpdatingLocation()
}
}


