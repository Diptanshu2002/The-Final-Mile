//
//  AssistDetailViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 21/02/23.
//

import UIKit
import CoreLocation
import MapKit

class AcceptDetailVC: UIViewController {
    
    var acceptInfo = ""
    
    
    var details = Request(
            address: "",
            name: "",
            userImg: "",
            status: "",
            pickupPoint: "",
            trackingId: "",
            deliveryPartnerContactNumber: "",
            deliveryPartnerName: "",
            date: "",
            time: "",
            packageSize: "",
            societyDeliveryPersonName: "",
            societyDeliveryPersonNumber: ""
        )
    
    
    
   
    
    
    //UI Label
    @IBOutlet weak var orderInfo: UIView!
    

    //UI Image linkers
    @IBOutlet weak var transactionIdImage: UIImageView!
    @IBOutlet weak var acceptDetailImageView: UIImageView!
    
    //Data Manipulation Labels
    @IBOutlet weak var acceptDetailLabel: UILabel! //name
    @IBOutlet weak var pickUpLocationLabel:UITextView!
    @IBOutlet weak var dropInLocation:UITextView!
    @IBOutlet weak var transactionIdLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var deliveryPartnerNameLabel:UILabel!
    @IBOutlet weak var deliveryPartnerContactNumber:UILabel!
    @IBOutlet weak var packageSizeLabel:UILabel!

    //Action
    @IBAction func directionButton(_ sender: UIButton){
        //        openMap(Address: "Sannasi Hostel SRM Kattankulathur")
        //        openAddressInMap(address: deliveryAddr)
                openMapsWithAddress(address: "SRM Chennai")
        //        openGoogleMaps(withLocation: "Sannasi Hostel SRM Chennai")
    }
    
    @IBAction func callButton(_ sender: UIButton){
        //need to add package owner contact number
        phone(phoneNum: "6290607898")
    }

        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false

        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        acceptDetailLabel.text = details.name
        pickUpLocationLabel.text = details.pickupPoint
        dropInLocation.text = details.address
        transactionIdLabel.text = details.trackingId
        dateLabel.text = details.date
        timeLabel.text = details.time
        deliveryPartnerNameLabel.text = details.deliveryPartnerName
        deliveryPartnerContactNumber.text = details.deliveryPartnerContactNumber
        packageSizeLabel.text = details.packageSize
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    private func style(){
        
        transactionIdImage.layer.masksToBounds = true
        transactionIdImage.layer.cornerRadius = transactionIdImage.frame.height / 2
        
        acceptDetailImageView.layer.masksToBounds = true
        acceptDetailImageView.layer.cornerRadius = acceptDetailImageView.frame.height / 2
        
//
        orderInfo.layer.cornerRadius = 8
//        orderInfo.layer.shadowColor = UIColor(named: "redBackground")?.cgColor
//        orderInfo.layer.shadowOpacity = 1
//        orderInfo.layer.shadowOffset = .zero
//        orderInfo.layer.shadowRadius = 2
        orderInfo.backgroundColor = UIColor(named: "redBackground")
    }
}










extension AcceptDetailVC {
    func openMap(Address: String){
        let mapAddress = Address.replacingOccurrences(of: " ", with: ",")
        print(mapAddress)

        UIApplication.shared.openURL(NSURL(string: "http://maps.apple.com/?address=\(mapAddress)")! as URL)

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
    
    
    func openGoogleMaps(withLocation location: String) {
            if let url = URL(string: "comgooglemaps://?q=\(location)") {
                UIApplication.shared.open(url)
            } else {
                print("Error: Google Maps not installed.")
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
