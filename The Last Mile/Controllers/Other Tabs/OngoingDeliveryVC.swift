//
//  OngoingDeliveryViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 02/03/23.
//

import UIKit

class OngoingDeliveryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(done)
        )

        // Do any additional setup after loading the view.
    }
    

    @objc func done() {
            }
}
