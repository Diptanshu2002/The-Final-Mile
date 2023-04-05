//
//  HomeVC.swift
//  The Last Mile
//
//  Created by Diptanshu Mandal on 09/02/23.
//

import UIKit

class LeaderBoardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var mainLeaderBoard: UIImageView!
    @IBOutlet weak var leaderBoardTableView: UITableView!
    
    var leaderboard : [LeaderBoard] = [
        LeaderBoard(rank: 1, userName: "abc", credits: 5000),
        LeaderBoard(rank: 2, userName: "def", credits: 3000),
        LeaderBoard(rank: 3, userName: "ghi", credits: 1000),
        LeaderBoard(rank: 4, userName: "jkl", credits: 500),
        LeaderBoard(rank: 5, userName: "mno", credits: 10)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "LeaderBoard"
        navigationController?.navigationBar.prefersLargeTitles = true
        leaderBoardTableView.delegate = self
        leaderBoardTableView.dataSource = self
        
        leaderBoardTableView.layer.masksToBounds = true
        leaderBoardTableView.layer.cornerRadius = 8.0

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderBoardCard", for: indexPath)
        let cardCell = cell as? LeaderBoardTableViewCell
        let card = leaderboard[indexPath.row]
        cardCell?.rankLabel.text = "\(card.rank)"
        cardCell?.userNameLabel.text = card.userName
        cardCell?.creditsLabel.text = "\(card.credits) miles"
        if card.rank == 1 {
            cardCell?.medalImage.image = UIImage(named: "goldMedal")
        } else if card.rank == 2 {
                cardCell?.medalImage.image = UIImage(named: "silverMedal")
        } else if card.rank == 3 {
            cardCell?.medalImage.image = UIImage(named: "bronzeMedal")
        }
        if !(card.rank == 1 || card.rank == 2 || card.rank == 3) {
            cell.backgroundColor = UIColor(white: 0, alpha: 0)
        }
        return cell
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
//
//  LeaderBoard.swift
//  The Last Mile
//
//  Created by Aakriti Rawat on 23/02/23.
//


