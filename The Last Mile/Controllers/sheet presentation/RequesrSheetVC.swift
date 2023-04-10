//
//  RequesrSheetVC.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 07/04/23.
//

import UIKit

class RequesrSheetVC: UIViewController {

    var name:String = "Nil"
    var contact:String = "Nil"
    var trackingId:String = "Nil"
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var trackingIdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if name.count > 1 && contact.count > 1 {
            nameLabel.text = name
            contactLabel.text = contact
            trackingIdLabel.text = trackingId
        }
        
        
    }
}
