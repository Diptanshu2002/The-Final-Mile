
import UIKit

class RequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var requestCellImage: UIImageView!
    
    @IBOutlet weak var pickupLocationLabel: UILabel!
    @IBOutlet weak var pickupTimeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        requestCellImage.layer.masksToBounds = true
        requestCellImage.layer.cornerRadius = requestCellImage.frame.height / 2
        
        //new lines added.
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
        self.backgroundColor = .secondarySystemBackground
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
