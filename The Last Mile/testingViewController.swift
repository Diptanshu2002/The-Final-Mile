//
//  testingViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 23/03/23.
//

import UIKit
import MapKit
import CoreLocation

class testingViewController: UIViewController {
    
    @IBOutlet weak var openMapOutlet: UIButton!
    
    @IBAction func openMapButton(_ sender: UIButton) {
        openMap(Address: "SRM,Chennai")
    }
    
    func openMap(Address: String){
        UIApplication.shared.openURL(NSURL(string: "http://maps.apple.com/?address=\(Address)")! as URL)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}
