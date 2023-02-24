import UIKit

class ProfileVC: UIViewController{
        
    @IBOutlet weak var imageNameView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
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
        
        styling()
    }
    
    
    private func styling(){
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
        
        imageNameView.layer.cornerRadius = 8
        imageNameView.layer.shadowColor = UIColor.systemGray3.cgColor
        imageNameView.layer.shadowOpacity = 1
        imageNameView.layer.shadowOffset = .zero
        imageNameView.layer.shadowRadius = 2
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
        print(indexPath.section)
    }
    
}
