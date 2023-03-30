//
//  AddAddressFormVC.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 17/03/23.
//

import UIKit

class AddAddressFormVC: UIViewController {
    
    //UI Objects
    
    
    @IBOutlet weak var addressFormNB: UINavigationBar!
    
    @IBOutlet weak var houseAddressTF: UITextField!
    @IBOutlet weak var streetNameTF: UITextField!
    @IBOutlet weak var areaTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var pincodeTF: UITextField!
    
   
    //button outlet
    @IBOutlet weak var HomeButtonOutlet: UIButton!
    @IBOutlet weak var HostelButtonOutlet: UIButton!
    @IBOutlet weak var OfficeButtonOutlet: UIButton!
    
    var locationType = "Other"
    //Variables
    var streetName: String = ""
    var area: String = ""
    var city: String = ""
    
    @IBAction func HomeButton(_ sender: UIButton) {
        sender.tintColor = .systemRed
        HostelButtonOutlet.tintColor = .systemBlue
        OfficeButtonOutlet.tintColor = .systemBlue
        locationType = "Home"
    }
    
    
    @IBAction func HostelButton(_ sender: UIButton) {
        sender.tintColor = .systemRed
        HomeButtonOutlet.tintColor = .systemBlue
        OfficeButtonOutlet.tintColor = .systemBlue
        locationType = "Hostel"
    }
    
    
    @IBAction func OfficeButton(_ sender: UIButton) {
        sender.tintColor = .systemRed
        HomeButtonOutlet.tintColor = .systemBlue
        HostelButtonOutlet.tintColor = .systemBlue
        locationType = "Office"
    }
    
    
    
    
    //Saving the new address
    @IBAction func saveAddressButton(_ sender: Any) {
        
        guard let houseAddress = houseAddressTF.text,
              let pincode = pincodeTF.text
        else{
            return
        }
        
        let address = Addresses(
            locationType: locationType,
            houseAddress: houseAddress,
            streetName: streetName,
            area: area,
            city: city,
            pincode: pincode)
        
        let result = DataManagar.shared.postNewAddress(newAddress: address)
        
        print("address form",houseAddress,streetName,area,city,pincode, locationType)
        
        navigationController?.popToRootViewController(animated: true)
        
              
    }
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addressFormNB.topItem?.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(cancel)
        )
        self.addressFormNB.topItem?.title = "  "
        self.addressFormNB.barTintColor = .systemBackground
        
        streetNameTF.placeholder = streetName
        areaTF.placeholder = area
        cityTF.placeholder = city
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
//        print("from address form", streetName, area, city)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}


extension AddAddressFormVC {
    @objc func cancel(){
        navigationController?.popToRootViewController(animated: true)
    }
}
