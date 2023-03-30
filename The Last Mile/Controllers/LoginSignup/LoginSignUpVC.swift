//
//  LoginSignUpVC.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 27/03/23.
//

import UIKit



class LoginSignUpVC: UIViewController{
    
    var count = 0
    var isLoggedInUser: Bool = false

    @IBAction func loginButton(_ sender: UIButton) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            {
            vc.callBack = { (_ isLoggedIn: Bool) in
                self.isLoggedInUser = isLoggedIn
                    }
              vc.modalPresentationStyle = .fullScreen
              self.present(vc, animated: true)
            }
        
    }
    
    
    @IBAction func SignUpButton(_ sender: UIButton) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC {
            vc.callBack = { (_ isLoggedIn: Bool) in
                self.isLoggedInUser = isLoggedIn
                    }
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)


            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        count = count+1
        print("view will appear", count)
        if isLoggedInUser {
            self.dismiss(animated: true)
        }
    }


}
