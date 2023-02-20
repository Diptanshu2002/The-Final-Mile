//
//  ProfileTableViewCell.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 19/02/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileCellIcon: UIImageView!
    @IBOutlet weak var profileCellLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileCellIcon.tintColor = .systemRed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
