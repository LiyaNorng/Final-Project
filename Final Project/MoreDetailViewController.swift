//
//  MoreDetailViewController.swift
//  Final Project
//
//  Created by Liya Norng on 5/2/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import UIKit

class MoreDetailViewController: UIViewController {

    
    var model = CollectionOfPlayer.instance
    @IBOutlet weak var textViewInfo: UITextView!

    @IBAction func userAction(_ sender: UIButton) {
        self.alert()
    }
    
    /**
     this method will attempt to warn the player what happen when they try to delete its account.
     */
    func alert()->Void{
        let alert = UIAlertController(title: "Are you sure?", message: "if you delete, your account will be erase from the data", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "delete", style: .default, handler: { (action) in
            self.model.removePlayerFromDictionary()
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
            self.performSegue(withIdentifier: "deleteSegue", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    /**
     This will load the current player info to a text field view. 
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = ("Player Background")
        self.textViewInfo.text.removeAll()
        let currentPlayer = self.model.currentPlayer
        self.textViewInfo.text.append("First Name: \(currentPlayer!.firstName)\n")
        self.textViewInfo.text.append("Last Name: \(currentPlayer!.lastName)\n")

        self.textViewInfo.text.append("Age: \(currentPlayer!.age)\n")

        self.textViewInfo.text.append("UserName: \(currentPlayer!.userName)\n")
        self.textViewInfo.text.append("List of Score:\n")
        for i in 0..<currentPlayer!.score.count{
            self.textViewInfo.text.append("\(i + 1):        \(currentPlayer!.score[i])%\n")
        }
    }
}
