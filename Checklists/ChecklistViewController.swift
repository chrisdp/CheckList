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
  
  // -------------------------------------------------- EVENT HANDLERS
  @IBAction func addItem() {
    
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
    
    // update label text
    let item = rowitem[indexPath.row]
    
    // update text and accessory type
    configureTextForCell(cell, withCheckItem: item)
    configureCheckmarkForCell(cell, withCheckItem: item)
    return cell
  }
  
  func configureTextForCell(cell: UITableViewCell, withCheckItem item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
  func configureCheckmarkForCell(cell: UITableViewCell, withCheckItem item: ChecklistItem) {
    // check to see if checkmark should be displayed
    if (item.checked) {
      cell.accessoryType = .Checkmark
    } else {
      cell.accessoryType = .None
    }
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // get cell reference
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      let item = rowitem[indexPath.row]
      // flip accessory indicator and update type
      item.toggleChecked()
      configureCheckmarkForCell(cell, withCheckItem: item)
    }
    // display short fadeout rather than staying selected
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

