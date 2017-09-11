//
//  TableViewController.swift
//  SpecToolsExample
//
//  Created by Ondrej Rafaj on 09/09/2017.
//  Copyright © 2017 manGoweb. All rights reserved.
//

import Foundation
import UIKit


class TableViewController: UITableViewController {
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: Table view delegate & data source methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.textLabel?.text = "Cell title with row: \(indexPath.row)"
        cell.detailTextLabel?.text = "Cell description with row: \(indexPath.row)"
        cell.customLabel.text = "Index: \(indexPath.row)"
        cell.customImageView.image = UIImage(named: "Icon-Small-40")
        return cell
    }
    
}
