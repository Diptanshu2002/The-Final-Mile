//
//  AddRequestViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 23/02/23.
//

//MARK: ADDING DATA TO THE REQUESTVC DIRECTLY NOT WORKING....... NEED TO RESOLVE



import UIKit

//protocol SubviewDelegate {
//    func subviewWillClose()
//}

class AddRequestViewController: UIViewController {
    
//    var delegate: SubviewDelegate?
    var requestTableViewRef: UITableView!
    
    var deliveryPartner: String = "other";
    let userDetails: Profile = DataManagar.shared.getUserProfile()

    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var deliveryPartnerLabel: UITextField!
    @IBOutlet weak var pickUpPoint: UITextField!
    @IBOutlet weak var trackingId: UITextField!
    @IBOutlet weak var deliveryPartnerContactNumber: UITextField!
    @IBOutlet weak var packageSizeTF: UITextField!
    
    @IBOutlet weak var amazonButtonOutlet: UIButton!
    @IBOutlet weak var flipkartPartnerButtonOutlet: UIButton!
    @IBOutlet weak var zomatoPartnerButtonOutlet: UIButton!

    
    
    //ACTION: CHANGE BUTTON COLOR DEPENDING ON SELECTION
    @IBAction func AmazonButton(_ sender: UIButton) {
        deliveryPartner = "amazon"
        sender.tintColor = .systemRed
        flipkartPartnerButtonOutlet.tintColor = .systemBlue
        zomatoPartnerButtonOutlet.tintColor = .systemBlue
    }
    
    @IBAction func ZomatoButton(_ sender: UIButton) {
        deliveryPartner = "zomato"
        sender.tintColor = .systemRed
        flipkartPartnerButtonOutlet.tintColor = .systemBlue
        amazonButtonOutlet.tintColor = .systemBlue
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        navBar.topItem?.title = "  "
        navBar.topItem?.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(done)
        )
        
        navBar.topItem?.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(cancel)
        )
        
        textFieldStyling()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
//            delegate?.subviewWillClose()
//        requestTableViewRef.reloadData()
        
        }
    
    
    func textFieldStyling(){
        //deliveryPartner
        deliveryPartnerLabel.layer.masksToBounds = true
        deliveryPartnerLabel.layer.cornerRadius = 8
        deliveryPartnerLabel.layer.borderColor = UIColor.systemGray.cgColor
        deliveryPartnerLabel.layer.borderWidth = 1.0
        deliveryPartnerLabel.attributedPlaceholder = NSAttributedString(
            string: "If Other, Please Mention",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2]
        )
        
        //pickUpPoint
        pickUpPoint.layer.masksToBounds = true
        pickUpPoint.layer.cornerRadius = 8
        pickUpPoint.layer.borderColor = UIColor.systemGray.cgColor
        pickUpPoint.layer.borderWidth = 1.0
        pickUpPoint.attributedPlaceholder = NSAttributedString(
            string: "Pick Up Point",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2]
        )
        
        //trackingId
        trackingId.layer.masksToBounds = true
        trackingId.layer.cornerRadius = 8
        trackingId.layer.borderColor = UIColor.systemGray.cgColor
        trackingId.layer.borderWidth = 1.0
        trackingId.attributedPlaceholder = NSAttributedString(
            string: "Tracking ID",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2]
        )
        
        //deliveryPartnerContactNumber
        deliveryPartnerContactNumber.layer.masksToBounds = true
        deliveryPartnerContactNumber.layer.cornerRadius = 8
        deliveryPartnerContactNumber.layer.borderColor = UIColor.systemGray.cgColor
        deliveryPartnerContactNumber.layer.borderWidth = 1.0
        deliveryPartnerContactNumber.attributedPlaceholder = NSAttributedString(
            string: "Delivery Partner Contact Number",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2]
        )
        
    }
}


extension AddRequestViewController {
    
    @objc func done() {
        
        let currentAddress = DataManagar.shared.getAddresses()
        
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        let date = "\(String(describing: dateTimeComponents.day!))-\(String(describing: dateTimeComponents.month!))-\(String(describing: dateTimeComponents.year!))"
        
        let time = "\(String(describing: dateTimeComponents.hour!)):\(String(describing: dateTimeComponents.minute!))"
        
        
        guard let pickUpPoint = pickUpPoint.text,
              let trackingId = trackingId.text,
              let deliveryPartnerContactNumber = deliveryPartnerContactNumber.text,
              let packageSizeTF = packageSizeTF.text else{
            return
        }
        
        if deliveryPartner == "other" {
            guard let deliveryPartner = deliveryPartnerLabel.text else{
                return
            }
            self.deliveryPartner = deliveryPartner
        }
        
        if currentAddress.isEmpty{
            
            self.present(Service.createAlertController(title: "No Address Found", message: "Create New Address under the Profile Section"), animated: true)
        }else{
            let deliveryAddress = "\(currentAddress[0].houseAddress),\(currentAddress[0].streetName),\(currentAddress[0].area),\(currentAddress[0].city),\(currentAddress[0].pincode)"
            
            let newRequest = Request(
                address: deliveryAddress,
                name: userDetails.profileName,
                userImg: userDetails.profileImg,
                status: RequestStatus.onRequest.rawValue,
                pickupPoint: pickUpPoint,
                trackingId: trackingId,
                deliveryPartnerContactNumber: deliveryPartnerContactNumber,
                deliveryPartnerName: deliveryPartner,
                date: date,
                time: time,
                packageSize: packageSizeTF,
                societyDeliveryPersonName: "",
                societyDeliveryPersonNumber: ""
            )
            
            print(newRequest)
            let result = DataManagar.shared.postNewRequest(newRequest: newRequest)
            self.dismiss(animated: true) {
                self.requestTableViewRef.reloadData()
                
            }
        }
    }
    
    
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
}
