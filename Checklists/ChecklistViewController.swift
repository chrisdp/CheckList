//
//  ViewController.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-09.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        switch indexPath.row {
        case 0:
            label.text = "Walk the dog"
        case 1:
            label.text = "Brush my teeth"
        case 2:
            label.text = "Learn iOS development"
        case 3:
            label.text = "Soccer practice"
        case 4:
            label.text = "Eat ice cream"
        default:
            break
        }
        
        return cell
    }

}

