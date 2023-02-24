//
//  AcceptTableViewCell.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 20/02/23.
//

import UIKit

class AcceptTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pickUpTitleLabel: UILabel!
    @IBOutlet weak var pickUpLocationLabel: UILabel!
    @IBOutlet weak var dropTitleLabel: UILabel!
    @IBOutlet weak var dropLocationTitleLabel: UILabel!
    
    @IBOutlet weak var totalCoinWillEarnLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    
    @IBOutlet weak var deliveryPartnerImage: UIImageView!
    
    

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
