//
//  ViewController.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-09.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
  
  // label text values
  var rowtext = ["Walk the dog", "Brush my teeth", "Learn iOS development", "Soccer practice", "Eat ice cream"]
  
  // completed/not completed state
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
    // determine how many items can be show
    return rowtext.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // get cell and label reference
    let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
    let label = cell.viewWithTag(1000) as! UILabel
    
    // update label text
    label.text = rowtext[indexPath.row]
    
    // update accessory type
    configureCheckmarkForCell(cell, indexPath: indexPath)
    return cell
  }
  
  func configureCheckmarkForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
    // check to see if checkmark should be displayed
    if (rowchecked[indexPath.row]) {
      cell.accessoryType = .Checkmark
    } else {
      cell.accessoryType = .None
    }
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // get cell reference
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      // flip accessory indicator and update type
      rowchecked[indexPath.row] = !rowchecked[indexPath.row]
      configureCheckmarkForCell(cell, indexPath: indexPath)
    }
    // display short fadeout rather than staying selected
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

