//
//  RequestViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 23/02/23.
//

import UIKit
class RequestViewController: UIViewController {
        

    @IBOutlet weak var requestTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTableView.delegate = self
        requestTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}


extension RequestViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "request_cell", for: indexPath)
        let requestCell = cell as? RequestTableViewCell
        requestCell?.requestCellImage.image = UIImage(named: "zomato")
        requestCell?.statusLabel.text = "On Request"
        requestCell?.pickupTimeLabel.text = "9:41"
        requestCell?.pickupLocationLabel.text = "Near Shiv Mandir SRM"
        
        return cell
    }
}
