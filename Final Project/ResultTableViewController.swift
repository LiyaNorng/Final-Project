//
//  ResultTableViewController.swift
//  Final Project
//
//  Created by Welcom on 4/15/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {

    var model = CollectionOfPlayer.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Players"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.model.listOfPlayer.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        self.model.removePlayerFromArray()
        self.model.addPlayerToArray()
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.textLabel?.text = self.model.arrayOfPlayer[row].userName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.model.set(currentPlayer: self.model.arrayOfPlayer[indexPath.row].userName)
        performSegue(withIdentifier: "moreDetail", sender: nil)
    }
}
