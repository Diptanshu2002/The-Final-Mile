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
    @IBOutlet weak var deliveredButtonOutlet: UIButton!
    
    //Action
    @IBAction func openDirectionButton(_ sender: UIButton){
//        openMap(Address: "Sannasi Hostel SRM Kattankulathur")
//        openAddressInMap(address: deliveryAddr)
//        openMapsWithAddress(address: "SRM Chennai")
//        openGoogleMaps(withLocation: "Sannasi Hostel SRM Chennai")
    }
    
    @IBAction func openCallButton(_ sender: UIButton){
//        if let url = URL(string: "tel://\(contactNumber)") {
//             UIApplication.shared.openURL(url)
//         }
//        phone(phoneNum: contactNumber)
    }
    
    
    @IBAction func deliveredButton(_ sender: UIButton){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deliveredButtonOutlet.setTitle("Swipe To Complete Delivery", for: .normal)
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(completeButtonSwiped))
                swipeGestureRecognizer.direction = .right
        deliveredButtonOutlet.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @objc func completeButtonSwiped() {
        deliveredButtonOutlet.isSelected = true
        deliveredButtonOutlet.setTitle("Thank You For Delivery", for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dismiss(animated: true)
            print("1 seconds have passed!")
        }
        
        print("button swiped")
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
    
}
