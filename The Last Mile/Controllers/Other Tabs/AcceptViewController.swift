
import UIKit

class AcceptViewController: UIViewController {
    
    @IBOutlet weak var acceptTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        acceptTableView.showsHorizontalScrollIndicator = false
        acceptTableView.showsVerticalScrollIndicator = false
        acceptTableView.delegate = self
        acceptTableView.dataSource = self
    }
}


extension AcceptViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accept_cell", for: indexPath)
        let accept_Cell = cell as? AcceptTableViewCell
        
        accept_Cell?.dropTitleLabel.text = "Drop In"
        accept_Cell?.dropLocationTitleLabel.text = "Sannasi-C 404"
        accept_Cell?.pickUpTitleLabel.text = "Pick Up"
        accept_Cell?.pickUpLocationLabel.text = "SRM Arch Gate"
        accept_Cell?.totalCoinWillEarnLabel.text = "20"
        accept_Cell?.deliveryPartnerImage.image = UIImage(named: "zomato")
        
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
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AcceptDetailViewController") as? AcceptDetailViewController {
            self.navigationController?.pushViewController(vc, animated: true)
//            self.present(vc, animated: true)
            }
    }
    
    
    
}
