//
//  SignUpVC.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 27/03/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SignUpVC: UIViewController {
    var callBack: ((_ isLoggedIn: Bool)-> Void)?
    
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UITextField!
    @IBOutlet weak var contactLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButton(_ sender: UIButton){
        guard let email = emailLabel.text,
              let password = passwordLabel.text,
              let confirmPassword = confirmPasswordLabel.text,
              let name = nameLabel.text,
              let contact = contactLabel.text,
              password == confirmPassword else{
            return
        }
        print(email, password, confirmPassword, name, contact)
        
        AuthManager.signUpUser(email: email, name: name, password: password) {
            self.callBack?(true)
            self.dismiss(animated: false)
        } OnError: { error in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true)
        }
    }
    
}
