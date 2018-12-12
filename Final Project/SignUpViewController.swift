//
//  SignUpViewController.swift
//  Final Project
//
//  Created by Welcom on 4/15/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var complainLabel: UILabel!
    
    var firstName:String = ""
    var lastName:String = ""
    var userName:String = ""
    var password:String = ""
    var age:Int = 0
    var model = CollectionOfPlayer.instance
    
    /**
     This method alow player to either cancel the input they just put in and return back to the welcome in page.
     */
    @IBAction func userAction(_ sender: UIButton) {
   
        let currentTitle = sender.currentTitle
        
        if currentTitle == "Done"{
            self.check()
        }
        else if currentTitle == "Cancel"{
            self.navigationController?.isNavigationBarHidden = true
            performSegue(withIdentifier: "multipleSegue", sender: nil)
        }
    }
    
    /**
     This method is used for checking if the player put in all the require input. Also checking if there is any name in the data that matches with current player. If not it will then add the current player to the system.
     */
    func check()->Void{
        if self.firstName != "" && self.lastName != "" && self.userName != "" && self.password != "" && self.age > 0{
            let tempUser = User(firstName: self.firstName, lastName: self.lastName, userName: self.userName, password: self.password, age: self.age)
            if self.model.checkForUser(userName: self.userName, password: self.password){
                self.complainLabel.text = "Sorry, that account had been created."
            }
            else {
                self.model.addUser(user: tempUser)
                self.model.successful = true
                self.model.set(currentPlayer: self.userName)
                performSegue(withIdentifier: "multipleSegue", sender: nil)
            }
        }
        else {
            self.complainLabel.text = "Please complete the form"
        }
    }
    
    /**
     this method take in all the input from the player. it also confirm that the age input is a number not a string. it will not stop asking the player for an int until player is putting the value of an int. 
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.complainLabel.text = ""
        if textField.tag == 0{   /// first name
            self.firstName = textField.text!
        }
        else if textField.tag == 1{  /// last name
            self.lastName = textField.text!
        }
        else if textField.tag == 2{   /// age
            let enteredText = Int(textField.text!)
            if enteredText == nil{
                textField.placeholder = "Please give a number"
                textField.text = ""
            }
            else{
                self.age = enteredText!
            }
        }
        else if textField.tag == 3{  /// username
            self.userName = textField.text!
        }
        else if textField.tag == 4{   /// password
            self.password = textField.text!
        }
        textField.resignFirstResponder()
        return true
    }
}
