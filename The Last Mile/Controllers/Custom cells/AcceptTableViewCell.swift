//
//  AcceptTableViewCell.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 20/02/23.
//

import UIKit

protocol MyCellDelegate: AnyObject {
    func didSelectButtonInCell(_ cell: AcceptTableViewCell)
}


class AcceptTableViewCell: UITableViewCell {
    
    weak var delegate: MyCellDelegate?
    
    var isAccept = false
    
    var index: Int = 0
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
//    @IBOutlet weak var pickUpTitleLabel: UILabel!
    @IBOutlet weak var pickUpLocationLabel: UILabel!
    @IBOutlet weak var dropTitleLabel: UILabel!
    @IBOutlet weak var dropLocationTitleLabel: UILabel!
    
    @IBOutlet weak var totalCoinWillEarnLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    
    @IBOutlet weak var deliveryPartnerImage: UIImageView!
    
    @IBOutlet weak var acceptButtonOutlet : UIButton!
    
    
    @IBAction func acceptButton(_ sender: UIButton){
        
        if details.status == RequestStatus.onRequest.rawValue{
            details.status = RequestStatus.onAccept.rawValue
            DataManagar.shared.setOngoingDelivery(delivery1: details)
            DataManagar.shared.deleteBulletin(index: details.trackingId)
            
            
            print("details : ", details)
        }
        
        delegate?.didSelectButtonInCell(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.backgroundColor = UIColor(red: 235.0/255.0, green: 69.0/255.0, blue: 95.0/255.0, alpha: 0.15)
        self.backgroundColor = .secondarySystemBackground
        deliveryPartnerImage.layer.masksToBounds = true
        deliveryPartnerImage.layer.cornerRadius = deliveryPartnerImage.frame.height / 2
        
        
        self.layer.cornerRadius = 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
