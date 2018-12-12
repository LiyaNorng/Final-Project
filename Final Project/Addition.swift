//
//  Addition.swift
//  Final Project
//
//  Created by Welcom on 4/15/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import Foundation

class Addition{
    
    var leftSide:Int
    var rightSide:Int
    var answer:Int
    var age:Int
    
    init (){
        self.leftSide = 0
        self.rightSide = 0
        self.answer = 0
        self.age = 0
    }
    
    /**
     this method is used to distinc the dificulty between each player by their age.
     */
    func getRandomNumber()->Int{
        if self.age < 10 { //"kid"
            return Int(arc4random_uniform(9))
        }
        else if self.age >= 10 && self.age < 21 { //"teen"
            return Int(arc4random_uniform(99))
        }
        else if self.age >= 21 { // "adult"
            return Int(arc4random_uniform(999))
        }
        else {
            return 0
        }
    }

    func setUpTheEquation()->Void{

        self.leftSide = self.getRandomNumber()
        self.rightSide = self.getRandomNumber()
        self.answer = self.leftSide + self.rightSide
    }
}
