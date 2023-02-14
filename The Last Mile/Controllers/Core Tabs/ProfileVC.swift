import UIKit

class ProfileVC: UIViewController{
        
    @IBOutlet weak var imageNameView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.delegate = self
        tableView.dataSource = self
        self.registerTableViewCells()
        
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
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "AddressCustomTableViewCell",
                                  bundle: nil)
        tableView.register(textFieldCell,
                                forCellReuseIdentifier: "addressCell")
    }
    
}



extension ProfileVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Options"
        }
        else{
            return "Addresses"
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let sectionView = (view as? UITableViewHeaderFooterView)
        sectionView?.textLabel?.textColor = .red
        sectionView?.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you selected \(indexPath.row)")
    }
    

    
}





extension ProfileVC :UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Detailcell", for: indexPath)
            cell.textLabel?.text = "Text"
            cell.accessoryType = .detailButton
            return cell
        }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
            return cell
        }
    }
    
    
}
