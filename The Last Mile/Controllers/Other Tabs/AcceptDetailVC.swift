//
//  AssistDetailViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 21/02/23.
//

import UIKit

class AcceptDetailVC: UIViewController {

    var acceptInfo = "accept"
    var details: Delivery = Delivery(
        request:Request(
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
            packageSize: ""
        ),
        deliveryPersonName: "",
        timestamp: Double()
    )
    
    
    
   
    
    
    //UI Label
    @IBOutlet weak var orderInfo: UIView!
    
    //UI Button
    @IBOutlet weak var acceptButtonLabel: UIButton!
    
    
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



    
    @IBAction func acceptButton(_ sender: UIButton) {
        
        if acceptInfo == "accept" {
            sender.setTitle("More Info", for: .normal)
            acceptButtonLabel.layer.backgroundColor = UIColor(named: "systemBlue")?.cgColor
        }else{
            sender.setTitle("Accept", for: .normal)
        }
        
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "OngoingDeliveryViewController") as? OngoingDeliveryVC {
            
            vc.deliveryAddr = details.request.address
            vc.contactNumber = details.request.deliveryPartnerContactNumber
            
            navigationController?.pushViewController(vc, animated: true)
            }
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        acceptDetailLabel.text = details.request.name
        pickUpLocationLabel.text = details.request.pickupPoint
        dropInLocation.text = details.request.address
        transactionIdLabel.text = details.request.trackingId
        dateLabel.text = details.request.date
        timeLabel.text = details.request.time
        deliveryPartnerNameLabel.text = details.request.deliveryPartnerName
        deliveryPartnerContactNumber.text = details.request.deliveryPartnerContactNumber
        packageSizeLabel.text = details.request.packageSize
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
