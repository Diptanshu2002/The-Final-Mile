
import UIKit

class AddressVC: UIViewController {
    @IBOutlet weak var addressTableView: UITableView!
    
    var addresses: [Addresses] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //ADDING NEW ADDRESS
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addAddress)
        )

        
        addressTableView.dataSource = self
        addressTableView.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
//        print("inside addressVC",addresses[0].locationType)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.hidesBottomBarWhenPushed = false
    }
    
}


extension AddressVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address_cell", for: indexPath)
        let addressCell = cell as? AddressCustomTableViewCell
        
        addressCell?.addressDistance.text = "140m"
        addressCell?.addressType.text = addresses[indexPath.row].locationType
        addressCell?.fullAddress.text = "\(addresses[indexPath.row].houseAddress) \(addresses[indexPath.row].streetName) \(addresses[indexPath.row].area) \(addresses[indexPath.row].city)"
        
        
        return cell
    }
}


extension AddressVC {
    
    @objc public func addAddress(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddAddressMapVC") as? AddAddressMapVC {
            self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
}
