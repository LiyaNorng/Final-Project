//
//  CollectionOfPlayer.swift
//  Final Project
//
//  Created by Liya Norng on 5/2/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import Foundation

class CollectionOfPlayer: NSObject, NSCoding{
    
    var listOfPlayer:[String:User] = [:]
    var arrayOfPlayer:[User] = []
    var currentPlayer:User!
    static var instance:CollectionOfPlayer = CollectionOfPlayer()
    var successful:Bool = false

    func set(currentPlayer:String)->Void{
        self.currentPlayer = self.listOfPlayer[currentPlayer]
    }
    
    func get()->User{
        return currentPlayer
    }
    
    override init (){
        /// do nothing
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.listOfPlayer = aDecoder.decodeObject(forKey: "player") as! [String:User]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.listOfPlayer, forKey: "player")
    }
    
    func checkForUser(userName:String, password:String)->Bool{
        if self.listOfPlayer.description.contains(userName){
            let tempUser = self.listOfPlayer[userName]
            if tempUser?.password == password{
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    func addUser(user:User)->Void{
        self.listOfPlayer[user.userName] = user
    }
    
    func addPlayerToArray()->Void{
        for (key, _) in self.listOfPlayer{
            self.arrayOfPlayer.append(self.listOfPlayer[key]!)
        }
    }
    
    func removePlayerFromDictionary()->Void{
        self.listOfPlayer.removeValue(forKey: self.currentPlayer.userName)
        for i in 0..<self.arrayOfPlayer.count{
            if self.currentPlayer == self.arrayOfPlayer[i]{
                self.arrayOfPlayer.remove(at: i)
                let temp = User(firstName: "", lastName: "", userName: "", password: "", age: 0)
                self.currentPlayer = temp
            }
        }
    }
    
    func removePlayerFromArray()->Void{
        self.arrayOfPlayer.removeAll()
    }
}

