//
//  UserGradesTableViewController.swift
//  Final Project
//
//  Created by Liya Norng on 5/3/17.
//  Copyright © 2017 Liya. All rights reserved.
//

import UIKit

class UserGradesTableViewController: UITableViewController {

    var model = CollectionOfPlayer.instance
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = ("Grade")
        self.model.currentPlayer.setLetterGrade()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.model.currentPlayer.score.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetail", for: indexPath)
        cell.textLabel?.text = ("Attempt \(row + 1)")
        cell.detailTextLabel?.text = ("\(self.model.currentPlayer.letterGrade[row])")
        return cell
    }
}



















