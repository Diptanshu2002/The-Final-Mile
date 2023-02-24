//
//  DeliveryVC.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 09/02/23.
//

import UIKit

class DeliveryVC: UIViewController {
    
    
    @IBOutlet weak var requestView:UIView!
    @IBOutlet weak var acceptView:UIView!
    
    
    @IBAction func switchViews(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            requestView.alpha = 1
            acceptView.alpha = 0
            
            navigationController?.navigationBar.topItem?.title = "Request"
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(addRequest)
            )
            
        }
        else{
            requestView.alpha = 0
            acceptView.alpha = 1
            navigationController?.navigationBar.topItem?.title = "Assist"
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = "Request"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addRequest)
        )
    }
    
}


extension DeliveryVC {
    
    @objc public func addRequest(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddRequestViewController") as? AddRequestViewController {
                self.present(vc, animated: true)
            }
    }
    
}
