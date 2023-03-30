//
//  AddAddressMapVC.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 07/03/23.
//

import UIKit
import MapKit
import CoreLocation

class AddAddressMapVC: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    let locManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var name = ""
    var sublocality = ""
    var subAdministrativeArea = ""
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddAddressFormVC") as? AddAddressFormVC {
            vc.streetName = name
            vc.area = sublocality
            vc.city = subAdministrativeArea
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text = "Loading"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.startUpdatingLocation()
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
    }
    
//    func userLocationString() -> String {
//        let userLocationString = "my home \(locality), \(administrativeArea), \(country)"
//        return userLocationString
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
                    if (error != nil) {
                        print("Error in reverseGeocode")
                        }
                let placemark = placemarks! as [CLPlacemark]
                        if placemark.count > 0 {
                            let placemark = placemarks![0]
                            
//                            self.locality = placemark.locality!
//                            self.administrativeArea = placemark.administrativeArea!
//                            self.country = placemark.country!
//                            print(self.userLocationString())
                            
                            print("debugging:\(placemark.country!)")
                            print("sublocality ",placemark.subLocality!)
                            print("location",placemark.location!)
                            print("name",placemark.name!)
                            print("subAdministrativeArea",placemark.subAdministrativeArea!)
                            
                            
                            self.locationLabel.text = "\(placemark.name!),  \(placemark.subLocality!), \(placemark.subAdministrativeArea!)"
                            
                            self.name = placemark.name!
                            self.sublocality = placemark.subLocality!
                            self.subAdministrativeArea = placemark.subAdministrativeArea!
                        }
                    })
            
            render(location)
        }
    }
    
    
    func render(_ location: CLLocation){
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude )
        let spanDegree = MKCoordinateSpan(latitudeDelta: 0.02,longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate,span: spanDegree)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

