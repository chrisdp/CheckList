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
  var rowitem = [ChecklistItem]()
  
  // dummy data (will be moved out later
  var tempytext = ["Walk the dog", "Brush my teeth", "Learn iOS development", "Soccer practice", "Eat ice cream"]
  var rowchecked = [false, true, false, false, true]
  
  // set out our own init
  required init?(coder aDecoder: NSCoder) {
    // populate rowitem array with ChecklistItem objects and set there values with dummy data
    for (index, value) in tempytext.enumerate() {
      rowitem.append(ChecklistItem())
      rowitem[index].text = value;
      rowitem[index].checked = rowchecked[index]
    }
    super.init(coder: aDecoder)
  }
  
  
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
    return rowitem.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // get cell and label reference
    let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
    let label = cell.viewWithTag(1000) as! UILabel
    
    // update label text
    label.text = rowitem[indexPath.row].text
    
    // update accessory type
    configureCheckmarkForCell(cell, indexPath: indexPath)
    return cell
  }
  
  func configureCheckmarkForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
    // check to see if checkmark should be displayed
    if (rowitem[indexPath.row].checked) {
      cell.accessoryType = .Checkmark
    } else {
      cell.accessoryType = .None
    }
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // get cell reference
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      // flip accessory indicator and update type
      rowitem[indexPath.row].checked = !rowitem[indexPath.row].checked
      configureCheckmarkForCell(cell, indexPath: indexPath)
    }
    // display short fadeout rather than staying selected
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

