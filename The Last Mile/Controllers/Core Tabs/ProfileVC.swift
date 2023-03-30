import UIKit
import FirebaseAuth

class ProfileVC: UIViewController{
    
    
    var userDetails: Profile = DataManagar.shared.getUserProfile()
        
    @IBOutlet weak var imageNameView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMiles: UILabel!
    
    
    
    struct Profile_Setting{
        var title: String
        var icon: UIImage
    }
    
    var settings: [Profile_Setting] = [
        Profile_Setting(title: "Address", icon: UIImage(named: "address")!),
        Profile_Setting(title: "My Request", icon: UIImage(named: "shop")!),
        Profile_Setting(title: "My Deliveries", icon: UIImage(named: "myDelivery")!),
        Profile_Setting(title: "Log Out", icon: UIImage(named: "logout")!)
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //Getting userDetails from the DataManager
//        print(userDetails)
        userName.text = userDetails.profileName
        profileImage.image = UIImage(named: "\(userDetails.profileImg)")//this parameter will change
        userMiles.text = String(userDetails.credits) + " Miles"
        styling()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userDetails = DataManagar.shared.getUserProfile()
        print("from profilePage", userDetails)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userName.text = userDetails.profileName
        profileImage.image = UIImage(named: "\(userDetails.profileImg)")//this parameter will change
        userMiles.text = String(userDetails.credits) + " Miles"
    }
    
    private func styling(){
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
        
        imageNameView.layer.cornerRadius = 8
//        imageNameView.layer.shadowColor = UIColor.systemGray3.cgColor
//        imageNameView.layer.shadowOpacity = 1
//        imageNameView.layer.shadowOffset = .zero
//        imageNameView.layer.shadowRadius = 2
        imageNameView.backgroundColor = .systemGray6
            
    }
}



extension ProfileVC: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: Creating number of section as number of setting.count
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profile_cell", for: indexPath)
        let profileCell = cell as? ProfileTableViewCell
        profileCell?.profileCellIcon?.image = settings[indexPath.section].icon
        profileCell?.profileCellLable?.text = settings[indexPath.section].title
        
        return cell
    }
    
     
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as? AddressVC {
                vc.addresses = userDetails.addresses
                print("from profileTable view",userDetails.addresses)
                self.navigationController?.pushViewController(vc, animated: true)
    //            self.present(vc, animated: true)
                }
        }
        if indexPath.section == 3 {
            let auth = Auth.auth()
            do{
                try auth.signOut()
            }catch let signOutError{
                self.present(
                    Service.createAlertController(
                        title: "Error",
                        message: signOutError.localizedDescription),
                    animated: true,
                    completion: nil
                )
            }
        }
    }
    
}
