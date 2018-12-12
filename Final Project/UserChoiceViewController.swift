//
//  UserChoiceViewController.swift
//  Final Project
//
//  Created by Liya Norng on 5/2/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import UIKit

class UserChoiceViewController: UIViewController {

    var model = CollectionOfPlayer.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ("\(self.model.currentPlayer.firstName) \(self.model.currentPlayer.lastName)")
    }
    
    /**
     this method is allows the player to return back the view where player have the option to attemp a different arithmetic. Player can sign out and it will take them to the welcome view. Player also can check othe other players info including themselve. Also players an check their score in a table view. 
     */
    @IBAction func userAction(_ sender: UIButton) {
        let currentTitle = sender.currentTitle
        
        if currentTitle == "Back"{
            performSegue(withIdentifier: "backSegue", sender: nil)
        }
        else if currentTitle == "Sign Out"{
            self.navigationController?.isNavigationBarHidden = true
            performSegue(withIdentifier: "exitSegue", sender: nil)
        }
        else if currentTitle == "Players"{
            performSegue(withIdentifier: "scoreSegue", sender: nil)
        }
        else if currentTitle == "Score Board"{
            performSegue(withIdentifier: "scoreBoardSegue", sender: nil)
        }
    }
}
