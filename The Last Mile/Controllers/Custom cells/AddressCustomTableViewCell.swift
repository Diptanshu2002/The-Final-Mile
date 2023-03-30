//
//  AddressCustomTableViewCell.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 11/02/23.
//

import UIKit

class AddressCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addressDistance: UILabel!
    
    @IBOutlet weak var addressType: UILabel!
    @IBOutlet weak var fullAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        fullAddress.lineBreakMode = .byCharWrapping
        fullAddress.numberOfLines = 0
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
        
}
