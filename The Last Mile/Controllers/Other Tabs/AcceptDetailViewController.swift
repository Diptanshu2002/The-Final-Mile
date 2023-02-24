//
//  AssistDetailViewController.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 21/02/23.
//

import UIKit

class AcceptDetailViewController: UIViewController {

    @IBOutlet weak var acceptDetailImageView: UIImageView!
    @IBOutlet weak var acceptDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        style()
    }
    
    private func style(){
        acceptDetailImageView.layer.masksToBounds = true
        acceptDetailImageView.layer.cornerRadius = acceptDetailImageView.frame.height / 2
    }
}
