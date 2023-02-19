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
        }
        else{
            requestView.alpha = 0
            acceptView.alpha = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
//        navigationController?.navigationBar.topItem?.title = "Delivery"
//        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
