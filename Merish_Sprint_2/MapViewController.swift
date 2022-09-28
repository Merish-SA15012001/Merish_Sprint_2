//
//  MapViewController.swift
//  Merish_Sprint_2
//
//  Created by Capgemini-DA202 on 9/24/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController{
//Mark: @IBOutlet
    var userlocation: CLLocation!
    @IBOutlet weak var mapView: MKMapView!

    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   // Mark: ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        detectUserLocation()
    }

// Function for detecting location
    func detectUserLocation(){
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            manager.startUpdatingLocation()
        }
    }
    
    // Function to set location
    
    func setLocation(handler: @escaping (String) -> Void){
        let location = CLLocation(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemark, error) -> Void in
            let placemark = placemark![0]
            let address = "\(placemark.locality ?? ""),\(placemark.subLocality ?? ""), \(placemark.subThoroughfare ?? ""), \(placemark.administrativeArea ?? "")"
            handler(address)
        })
    }

    @IBAction func ordernowbtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LocalNotifyViewController") as! LocalNotifyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// Mark: Extension
extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userlocation = locations[0] as CLLocation
        
        //latitude and longitude oh location
        let center = CLLocationCoordinate2D(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
        // set the location
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
        setLocation{(address) in
            annotation.title = address
        }
        self.mapView.addAnnotation(annotation)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Manager Error \(error.localizedDescription)")
    }
}
