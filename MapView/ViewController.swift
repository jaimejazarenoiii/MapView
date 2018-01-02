//
//  ViewController.swift
//  MapView
//
//  Created by Jaime Jazareno III on 02/01/2018.
//  Copyright © 2018 Jaime Jazareno III. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var latitude = 14.586936
    var longitude = 121.104625
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
        
        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let pinObject = MKPointAnnotation()
        
        pinObject.coordinate = pinLocation
        pinObject.title = "SM City East Ortigas"
        pinObject.subtitle = "Ortigas Ave Ext, Pasig, Metro Manila, Philippines"
        
        mapView.addAnnotation(pinObject)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func standard(_ sender: Any) {
        mapView.mapType = MKMapType.standard
    }
    
    @IBAction func satellite(_ sender: Any) {
        mapView.mapType = MKMapType.satellite
    }
    
    @IBAction func hybrid(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid
    }
    
    @IBAction func locateMe(_ sender: Any) {
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    @IBAction func directions(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://maps.apple.com/maps?daddr=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
        
    }
}

