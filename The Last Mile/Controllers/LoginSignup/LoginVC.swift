//
//  LoginVC.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 27/03/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginVC: UIViewController {

    var callBack: ((_ isLoggedIn: Bool)-> Void)?
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func login(_ sender: UIButton){
        
        guard let email = emailTF.text,
              let password = passwordTF.text else{
            return
        }
        
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if error != nil{
                self.present(
                    Service.createAlertController(
                        title: "Error",
                        message: error!.localizedDescription
                    ),
                    animated: true,
                    completion: nil
                )
                return
            }
            DataManagar.GetUserDetailsFromDatabase {
                
            } OnError: { error in
                print(error!.localizedDescription)
            }

            self.callBack?(true)
            self.dismiss(animated: false)
        }
    }

    @IBOutlet weak var navBar: UINavigationBar!
    override func viewDidLoad() {
        navBar.topItem?.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelButton)
        )
        super.viewDidLoad()
    }
}


extension LoginVC{
    @objc func cancelButton(){
        self.dismiss(animated: true)
    }
}
