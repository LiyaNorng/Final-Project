//
//  ViewController.swift
//  Final Project
//
//  Created by Welcom on 4/15/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var userName:String = ""
    var password:String = ""
    var model:CollectionOfPlayer!

    @IBOutlet weak var errorMessage: UILabel!
    
    
    /**
     Player can have two choices. Login or Sign up for a new account that has not been taken yet.
     */
    @IBAction func userAction(_ sender: UIButton) {
        
        let currentAction = sender.currentTitle
        
        if currentAction == "Login"{
            self.checkForAccount()
        }
        else if currentAction == "Sign up"{
            performSegue(withIdentifier: "signUpSegue", sender: nil)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0{
            self.userName = textField.text!
        }
        else if textField.tag == 1{
            self.password = textField.text!
        }
        textField.resignFirstResponder()
        return true
    }
    
    /**
     This method is used for searching for player in the data base. If it is located in the data, it will then load the player info and change the view to another view.
     */
    func checkForAccount()->Void{
        if self.model.checkForUser(userName: self.userName, password: self.password){
            self.model.set(currentPlayer: self.userName)
            //print ("current player  ::::     \(self.model.currentPlayer.userName)")
            self.model.successful = false
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        else {
            self.errorMessage.text = ("Sorry, there is no userName or password in our data base.")
        }
    }
    
    
    /**
        This method is used for check if there was a file name "savegame.data" If there is one it will load that file and load all the players. So it can then use to check if the user actually exist in the data.
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.errorMessage.text = ""
      
        self.model = CollectionOfPlayer.instance
        do {
            let url = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            
            let path = url.path + "/savegame.data"
            print ("\(path)")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: path) {

                let tempModel = NSKeyedUnarchiver.unarchiveObject(withFile: path) as! CollectionOfPlayer
                print("Load successful")
                
                if self.model.successful{
                    tempModel.addUser(user: self.model.currentPlayer)
                }
                CollectionOfPlayer.instance = tempModel
                self.model = CollectionOfPlayer.instance
                print ("got down here")
                
                
            } else {
                print("FILE NOT AVAILABLE")
            }
            
        } catch {
            print ("Something went wrong: \(error)")
        }
        
    }
}

