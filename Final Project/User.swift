//
//  User.swift
//  Final Project
//
//  Created by Welcom on 4/15/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding{
    
    var firstName:String
    var lastName:String
    var userName:String
    var password:String
    var age:Int
    var score:[Int]
    var letterGrade:[String]
    
    var totalScore:Int {
        get{
            var total:Int = 0
            
            for i in 0..<self.score.count{
                total += self.score[i]
            }
            return Int(total/self.score.count)
        }
    }
    
    init (firstName:String, lastName:String, userName:String, password:String, age:Int){
        
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.password = password
        self.age = age
        self.score = []
        self.letterGrade = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        self.userName = aDecoder.decodeObject(forKey: "userName") as! String
        self.password = aDecoder.decodeObject(forKey: "password") as! String
        self.age = aDecoder.decodeInteger(forKey: "age")
        self.score = aDecoder.decodeObject(forKey: "score") as! [Int]
        self.letterGrade = aDecoder.decodeObject(forKey: "letterGrade") as! [String]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.firstName, forKey: "firstName")
        aCoder.encode(self.lastName, forKey: "lastName")
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.password, forKey: "password")
        aCoder.encode(self.age, forKey: "age")
        aCoder.encode(self.score, forKey: "score")
        aCoder.encode(self.letterGrade, forKey: "letterGrade")
    }
    
    func convertToLetterGrad(number:Int)->String {
        if self.totalScore >= 90{
            return "A"
        }
        else if self.totalScore >= 80 && self.totalScore < 90{
            return "B"
        }
        else if self.totalScore >= 70 && self.totalScore < 80{
            return "C"
        }
        else if self.totalScore >= 60 && self.totalScore < 70{
            return "D"
        }
        else if self.totalScore < 60{
            return "F"
        }
        return ""
    }
    
    func setLetterGrade()->Void{
        self.letterGrade.removeAll()
        
        for i in 0..<self.score.count{
            self.letterGrade.append(self.convertToLetterGrad(number: score[i]))
        }
    }
    
    func add(score:Int)->Void{
        self.score.append(score)
    }
}
