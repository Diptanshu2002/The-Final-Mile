//
//  AddRequestViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 23/02/23.
//

import UIKit

class AddRequestViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        navBar.topItem?.title = "New Request"
        
        navBar.topItem?.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(done)
        )
        
        navBar.topItem?.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(cancel)
        )
        
    }
}


extension AddRequestViewController {
    
    @objc func done() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
}
