//
//  DeliveryVC.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 09/02/23.
//

import UIKit
import FirebaseAuth


class DeliveryVC: UIViewController {
    
    @IBOutlet weak var acceptView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = "Bulletin"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        DataManagar.GetUserDetailsFromDatabase {
            
        } OnError: { error in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataManagar.GetUserDetailsFromDatabase {
            
        } OnError: { error in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
}



extension DeliveryVC{
    func handleNotAuthenticated(){
//        if Auth.auth().currentUser == nil{
//            // show login screen
//            let loginVC = LoginViewController()
//            loginVC.modalPresentationStyle = .fullScreen
//            present(loginVC, animated: false)
//        }
        
        if Auth.auth().currentUser == nil{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginSignUpVC") as? LoginSignUpVC {
                vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false)
                }
        }
        
    }
}
