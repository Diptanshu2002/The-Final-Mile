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
        Profile_Setting(title: "Address", icon: UIImage(systemName: "location.circle.fill")!),
        Profile_Setting(title: "Orders", icon: UIImage(systemName: "bag.circle.fill")!)
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profile_cell", for: indexPath)
        let profileCell = cell as? ProfileTableViewCell
        profileCell?.profileCellIcon?.image = settings[indexPath.row].icon
        profileCell?.profileCellLable?.text = settings[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
