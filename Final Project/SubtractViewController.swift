//
//  SubtractViewController.swift
//  Final Project
//
//  Created by Welcom on 4/15/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import UIKit
import AVFoundation

class SubtractViewController: UIViewController {

    var subtract = Subtraction()
    var model = CollectionOfPlayer.instance
    var answer:Int = 0
    var currentScore = 0
    var counter = 0
    var timer:Timer!
    var totalQuestion:Int = 12
    
    @IBOutlet weak var leftSide: UILabel!
    
    @IBOutlet weak var clockLabel: UILabel!
    
    @IBOutlet weak var rightSide: UILabel!
    
    @IBOutlet var userSelection: [UIButton]!
    
    /**
     this method will check when the user pick the right answer according to the quesiton. If the player get it right, it will then has a text input audio saying if it is correct or incorrect. if the player get it right then it will have a running total to keep track how many did they get right and use that to get the actual score. After user pick one of the 4 options as an answer it will then reload a new question.
     */
    @IBAction func userAction(_ sender: UIButton) {
   
        let currentAction = sender.currentTitle
        let synth = AVSpeechSynthesizer()
        var myUtterance = AVSpeechUtterance(string: "")

        if currentAction == "Quit"{
            self.alert()
        }
        
        if currentAction == String(self.subtract.answer){
            self.currentScore += 1
            myUtterance = AVSpeechUtterance(string: "Correct!")
            self.setUpProblem()
        }
        else{
            myUtterance = AVSpeechUtterance(string: "Incorrect!")
            self.setUpProblem()
        }
        
        myUtterance.rate = 0.5
        synth.speak(myUtterance)
    }
    
    /**
     This method is storing the score into the current player
     */
    func addGrade()->Void{
        self.model.currentPlayer.add(score: (self.currentScore/self.totalQuestion)*100)
    }
    
    /**
     this method is used for alerting the player that if they quit the game, it will not safe the score. At the same time they can stop the timer as they read the warning sign.
     */
    func alert()->Void{
        self.timer.invalidate()
        let alert = UIAlertController(title: "Are you sure?", message: "if you quit, no score will be record for this round", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "quit", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "sSegue", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            self.startTimer(value: self.counter)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    /**
     This method is used for setting up the problem by getting a random number. It also check if one of the 4 answers r already input in the button. So it preven a duplicat answer.
     */
    func setUpProblem()->Void{
        self.subtract.setUpTheEquation()
        self.leftSide.text = String(self.subtract.leftSide)
        self.rightSide.text = String(self.subtract.rightSide)
        let randomPick = Int(arc4random_uniform(3))
        for i in 0..<self.userSelection.count{
            if randomPick == i{
                self.userSelection[i].setTitle(String(self.subtract.answer), for: UIControlState.normal)
            }
            else{
                var condition:Int = 0
                while (true){
                    self.answer = self.subtract.answer + Int(arc4random_uniform(9))
                    for i in 0..<self.userSelection.count{
                        if String(self.answer) == self.userSelection[i].currentTitle || String(self.subtract.answer) == String(self.answer){
                            condition = 1
                            break
                        }
                    }
                    if condition == 0{
                        break
                    }
                    condition = 0
                }
                self.userSelection[i].setTitle(String(self.answer), for: UIControlState.normal)
            }
        }
    }
    
    /**
     This is the timer method. When the timer is reached. it will then launch the view to another view preventing the player from putting any more input. To stop the test.
     */
    func startTimer(value:Int)->Void{
        self.counter = value
        self.timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { (t) in
                self.counter -= 1
                if self.counter >= 0 {
                    self.clockLabel.text = "\(self.counter)"
                } else {
                    self.addGrade()
                    self.performSegue(withIdentifier: "sSegue", sender: nil)
                    self.timer.invalidate()
                }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subtract.age = self.model.currentPlayer.age
        self.startTimer(value: 40)
        self.setUpProblem()
    }
}
