//
//  AccountViewController.swift
//  Final Project
//
//  Created by Welcom on 4/15/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    var model = CollectionOfPlayer.instance
    
    /**
     this method allows player to choose many different optoins such as addition, subtraction, dividsion, mulplication. Also allowing player to check for score if there is any from prevous ran. Also allowing player to logout from the system. When the player is logging out from the system, it will save the info on the current player to the data. It also update the pass player that matches the current player. 
     */
    @IBAction func userAction(_ sender: UIButton) {
 
        if sender.currentTitle == "add" {
            performSegue(withIdentifier: "aSegue", sender: nil)
        }
        else if sender.currentTitle == "subtract"{
            performSegue(withIdentifier: "sSegue", sender: nil)
        }
        else if sender.currentTitle == "divide"{
            performSegue(withIdentifier: "dSegue", sender: nil)
        }
        else if sender.currentTitle == "multiply"{
            performSegue(withIdentifier: "xSegue", sender: nil)
        }
        else if sender.currentTitle == "Score"{
            performSegue(withIdentifier: "scoreBoardSegue", sender: nil)
        }
        else if sender.currentTitle == "LogOut"{
            self.model.removePlayerFromArray()
            self.model.addPlayerToArray()
            do {
                let url = try FileManager.default.url(
                    for: .documentDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: false)
                
                let path = url.path + "/savegame.data"
                NSKeyedArchiver.archiveRootObject(self.model, toFile: path)
                print ("\(path)")

            } catch {
                print ("Something went wrong: \(error)")
            }
            self.navigationController?.isNavigationBarHidden = true
            performSegue(withIdentifier: "logOutSegue", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("current player  ::::     \(self.model.currentPlayer.userName)")

        self.navigationItem.title = "\(self.model.currentPlayer.firstName) \(self.model.currentPlayer.lastName)"
    }
}
