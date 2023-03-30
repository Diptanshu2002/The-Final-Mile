//
//  AuthManager.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 28/03/23.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static func signUpUser(email: String, name: String, password: String, onSuccess: @escaping ()-> Void, OnError: @escaping (_ error: Error?) -> Void){
        
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if error != nil{
                OnError(error!)
                return
            }
            DataManagar.UploadUserDetailsToDatabase(email: email, name: name, onSuccess: onSuccess)
        }
    }
    
    
    
}
