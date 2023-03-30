//
//  OngoingViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 02/03/23.
//

import UIKit
import CoreLocation
import MapKit

class OngoingDeliveryVC: UIViewController {
    
    
    //Variables
    var deliveryAddr = ""
    var contactNumber = ""
    
    //Outlets
    @IBOutlet weak var deliveryAddress: UILabel!
    
    //Action
    @IBAction func openDirectionButton(_ sender: UIButton){
//        openMap(Address: "Sannasi Hostel")
//        openAddressInMap(address: deliveryAddr)
        openMapsWithAddress(address: deliveryAddr)
    }
    
    @IBAction func openCallButton(_ sender: UIButton){
//        if let url = URL(string: "tel://\(contactNumber)") {
//             UIApplication.shared.openURL(url)
//         }
        phone(phoneNum: contactNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        deliveryAddress.text = deliveryAddr
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension OngoingDeliveryVC {
    
    func openMap(Address: String){
//        let mapAddress = Address.replacingOccurrences(of: " ", with: "-")
//        print(mapAddress)
//
//        UIApplication.shared.openURL(NSURL(string: "http://maps.apple.com/?address=\(mapAddress)")! as URL)

//        let myAddress = "SRM"
//        let geoCoder = CLGeocoder()
//        geoCoder.geocodeAddressString(myAddress) { (placemarks, error) in
//            guard let placemarks = placemarks?.first else { return }
//            let location = placemarks.location?.coordinate ?? CLLocationCoordinate2D()
//            guard let url = URL(string:"http://maps.apple.com/?daddr=\(location.latitude),\(location.longitude)") else { return }
//            UIApplication.shared.open(url)
//        }
    }
 
        
    func openAddressInMap(address: String?){
        guard let address = address else {return}

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks?.first else {
                return
            }

            let location = placemarks.location?.coordinate

            if let lat = location?.latitude, let lon = location?.longitude{
                let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)))
                destination.name = address

                MKMapItem.openMaps(
                    with: [destination]
                )
            }
        }
    }
    
    
    func openMapsWithAddress(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                // Handle the error
                print("Geocoding failed: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let mapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                mapItem.name = address
                
                // Set the options for the map launch
                let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                
                // Launch Apple Maps and open the location
                mapItem.openInMaps(launchOptions: launchOptions)
            }
        }
    }

    
    
    func phone(phoneNum: String) {
        if let url = URL(string: "tel://\(phoneNum)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
}
