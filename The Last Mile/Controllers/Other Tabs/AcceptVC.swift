
import UIKit

class AcceptVC: UIViewController {
    
    @IBOutlet weak var acceptTableView: UITableView!
    
    var deliveryDetails = DataManagar.shared.getBulletin()
    var onGoingDeliveryDetails = DataManagar.shared.getOngoingDelivery()
    
    var refreshControl: UIRefreshControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManagar.GetUserDetailsFromDatabase {
        } OnError: { error in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true)
        }
        
        onGoingDeliveryDetails = DataManagar.shared.getUserProfile().ongoing
        DataManagar.getBulletinDataFromDatabase {
            self.deliveryDetails = DataManagar.shared.getBulletin()
            self.acceptTableView.reloadData()
            print("view will appeart acceptVC ------------------")
        } OnError: { error in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true)
        }
        
        acceptTableView.showsHorizontalScrollIndicator = false
        acceptTableView.showsVerticalScrollIndicator = false
        acceptTableView.delegate = self
        acceptTableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        acceptTableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc func handleRefresh(){
        DataManagar.getBulletinLatestDataFromDatabase   {
            self.deliveryDetails = DataManagar.shared.getBulletin()
            self.acceptTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        onGoingDeliveryDetails = DataManagar.shared.getUserProfile().ongoing
//        onGoingDeliveryDetails = DataManagar.shared.getOngoingDelivery()
        print("onGoingDeliveryDetails",onGoingDeliveryDetails)
  //MARK: NEED TO UNCOMMENT THE LINE
        DataManagar.getBulletinDataFromDatabase {
            self.deliveryDetails = DataManagar.shared.getBulletin()
            self.acceptTableView.reloadData()
            print("view will appeart acceptVC ------------------")
        } OnError: { error in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true)
        }
        
        self.deliveryDetails = DataManagar.shared.getBulletin()
        print("inside the accpetVC", deliveryDetails)
        self.acceptTableView.reloadData()
    }
    
}




//MARK: ACCEPT VIEW TABLE
extension AcceptVC: UITableViewDelegate, UITableViewDataSource, MyCellDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return deliveryDetails.count + onGoingDeliveryDetails.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if onGoingDeliveryDetails.count > 0 {
            switch(section){
                case 0:
                  return "Accepted Request"
            case onGoingDeliveryDetails.count:
                    return "Request"
                default:
                    return ""
                }
        }else{
            switch(section){
                case 0:
                  return "Request"
                default:
                    return ""
                }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accept_cell", for: indexPath)
        let accept_Cell = cell as? AcceptTableViewCell
        
        if indexPath.section < onGoingDeliveryDetails.count{
            accept_Cell?.dropTitleLabel.text = "Pick Up"
            accept_Cell?.dropLocationTitleLabel.text = onGoingDeliveryDetails[indexPath.section].pickupPoint
            accept_Cell?.pickUpLocationLabel.text = onGoingDeliveryDetails[indexPath.section].name
            accept_Cell?.totalCoinWillEarnLabel.text = "20 Miles"
            accept_Cell?.deliveryPartnerImage.image = UIImage(named: "profileImage")
            accept_Cell?.details = onGoingDeliveryDetails[indexPath.section]
            accept_Cell?.index = indexPath.section
            accept_Cell?.delegate = self
            
        }else{
            accept_Cell?.dropTitleLabel.text = "Pick Up"
            accept_Cell?.dropLocationTitleLabel.text = deliveryDetails[indexPath.section - onGoingDeliveryDetails.count].request.pickupPoint
            accept_Cell?.pickUpLocationLabel.text = deliveryDetails[indexPath.section - onGoingDeliveryDetails.count].request.name
            accept_Cell?.totalCoinWillEarnLabel.text = "20 Miles"
            accept_Cell?.deliveryPartnerImage.image = UIImage(named: "profileImage")
            accept_Cell?.details = deliveryDetails[indexPath.section - onGoingDeliveryDetails.count].request
            accept_Cell?.index = indexPath.section
            accept_Cell?.delegate = self
        }
        
        
        
        return cell
    }
    
    //MARK: ACCEPT BUTTON FUNCTION
    func didSelectButtonInCell(_ cell: AcceptTableViewCell) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AcceptDetailViewController") as? AcceptDetailVC {
            
            var infoDetails = cell.details
            vc.details = infoDetails
        
            //function to delete the request from Allrequest
        
            //function to add in ongoing request of the user
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AcceptDetailViewController") as? AcceptDetailVC {

            if indexPath.section < onGoingDeliveryDetails.count {
                vc.details = onGoingDeliveryDetails[indexPath.section]
                vc.acceptInfo = "accept"
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
                if let vc = storyboard?.instantiateViewController(withIdentifier: "BulletinSheetVC") as? BulletinSheetVC {
                    
                    let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
                    let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
                        return 500
                    }
                    if let sheet = vc.sheetPresentationController{
                        sheet.detents = [smallDetent]
                        sheet.prefersGrabberVisible = true
                        sheet.preferredCornerRadius = 24
                    }
                    
                    self.navigationController?.present(vc, animated: true)
                    }
            }
        }
        
        
        
    }
    
    
    
    
    
}
