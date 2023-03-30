//
//  RequestViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 23/02/23.
//

import UIKit
import FirebaseAuth

class RequestVC: UIViewController {
    
    var isUserLogin = false
        
    
    var userRequest: [Request] = []
    @IBOutlet weak var requestTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        requestTableView.delegate = self
        requestTableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.title = "Request"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addRequest)
        )

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userRequest = DataManagar.shared.getUserRequest()
        requestTableView.reloadData()
        print("view will appear", userRequest)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}




extension RequestVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        userRequest.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "request_cell", for: indexPath)
        let requestCell = cell as? RequestTableViewCell
        requestCell?.requestCellImage.image = UIImage(named: userRequest[indexPath.section].deliveryPartnerName)
        requestCell?.statusLabel.text = userRequest[indexPath.section].status
        requestCell?.pickupTimeLabel.text = userRequest[indexPath.section].time
        requestCell?.pickupLocationLabel.text = userRequest[indexPath.section].pickupPoint
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}





extension RequestVC {
    
    @objc public func addRequest(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddRequestViewController") as? AddRequestViewController {
                vc.requestTableViewRef = requestTableView
                self.present(vc, animated: true)
            }
    }
    
}






//extension RequestVC: SubviewDelegate {
//
//    func subviewWillClose() {
//        requestTableView.reloadData()
//    }
//
//}
