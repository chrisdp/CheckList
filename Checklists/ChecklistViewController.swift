//
//  ViewController.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-09.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
  
  var rowtext = ["Walk the dog", "Brush my teeth", "Learn iOS development", "Soccer practice", "Eat ice cream"]
  
  var rowchecked = [false, true, false, false, true]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rowtext.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
    
    let label = cell.viewWithTag(1000) as! UILabel
    
    label.text = rowtext[indexPath.row]
    
    configureCheckmarkForCell(cell, indexPath: indexPath)
    return cell
  }
  
  func configureCheckmarkForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
    if (rowchecked[indexPath.row]) {
        cell.accessoryType = .Checkmark
    } else {
      cell.accessoryType = .None
    }
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      rowchecked[indexPath.row] = !rowchecked[indexPath.row]
      configureCheckmarkForCell(cell, indexPath: indexPath)
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

