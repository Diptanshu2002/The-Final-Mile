
import UIKit

class AcceptVC: UIViewController {
    
    @IBOutlet weak var acceptTableView: UITableView!
    
    var deliveryDetails = DataManagar.shared.getBulletin()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        acceptTableView.showsHorizontalScrollIndicator = false
        acceptTableView.showsVerticalScrollIndicator = false
        acceptTableView.delegate = self
        acceptTableView.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        DataManagar.getBulletinDataFromDatabase {
            self.deliveryDetails = DataManagar.shared.getBulletin()
            self.acceptTableView.reloadData()
            print("view will appeart acceptVC ------------------")
        } OnError: { error in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true)
        }
    }
    
}





extension AcceptVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return deliveryDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accept_cell", for: indexPath)
        let accept_Cell = cell as? AcceptTableViewCell
        
        accept_Cell?.dropTitleLabel.text = "Pick Up"
        accept_Cell?.dropLocationTitleLabel.text = deliveryDetails[indexPath.section].request.pickupPoint

        accept_Cell?.pickUpLocationLabel.text = deliveryDetails[indexPath.section].request.name
        accept_Cell?.totalCoinWillEarnLabel.text = "20 Miles"
        accept_Cell?.deliveryPartnerImage.image = UIImage(named: "profileImage")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AcceptDetailViewController") as? AcceptDetailVC {
            vc.details = deliveryDetails[indexPath.section]
            self.navigationController?.pushViewController(vc, animated: true)
            }
    }
}
