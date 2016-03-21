//
//  ViewController.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-09.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
  
  var checklist: Checklist!
  // ChecklistItem array
  var items: [ChecklistItem]
  
  // set out our own init
  required init?(coder aDecoder: NSCoder) {
    // initialize items array
    items = [ChecklistItem]()
    super.init(coder: aDecoder)
    // load existing items
    loadCheckistItems()
    
    // for debugging
    print("Documents folder is \(documentsDirectory())")
    print("Data file path is \(dataFilePath())")
  }
  
  // -------------------------------------------------- OVERRIDES/EVENT HANDLERS
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    title = checklist.name
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // determine how many items can be show
    return items.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // get cell and label reference
    let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
    
    // update label text
    let item = items[indexPath.row]
    
    // update text and accessory type
    configureTextForCell(cell, withCheckItem: item)
    configureCheckmarkForCell(cell, withCheckItem: item)
    return cell
  }
 
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    // remove the ChecklistItem at the matching index
    items.removeAtIndex(indexPath.row)
    
    // delete the corresponding row from the table view
    let indexPaths = [indexPath]
    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    saveCheclistItems()
  }
  
  func configureTextForCell(cell: UITableViewCell, withCheckItem item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
  func configureCheckmarkForCell(cell: UITableViewCell, withCheckItem item: ChecklistItem) {
    let label = cell.viewWithTag(1001) as! UILabel
    // check to see if checkmark should be displayed and update label
    label.text = (item.checked) ? "√" : ""
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // get cell reference
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      let item = items[indexPath.row]
      // flip accessory indicator and update type
      item.toggleChecked()
      configureCheckmarkForCell(cell, withCheckItem: item)
    }
    // display short fadeout rather than staying selected
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    saveCheclistItems()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // check what segue is about to happen
    if (segue.identifier == "AddItem") {
      
      // get the navigation controller and then get the actual ItemDetailViewController
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! ItemDetailViewController
      
      // set this controller as the delegate for the ItemDetailViewController during this sague
      controller.delegate = self
    } else if (segue.identifier == "EditItem") {
      // get the navigation controller and then get the actual ItemDetailViewController
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! ItemDetailViewController
      
      // set this controller as the delegate for the ItemDetailViewController during this sague
      controller.delegate = self
      
      // set the ChecklistItem to edit
      if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell ){
        controller.itemToEdit = items[indexPath.row]
      }
    }
  }
  // -------------------------------------------------- DATA PERSISTENCE
  func documentsDirectory() -> String {
    // find the documents directory for the app
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    return paths[0]
  }
  
  func dataFilePath() -> String {
    // return path to file
    return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
  }
  
  func saveCheclistItems() {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    
    // encode array into writable binary data
    archiver.encodeObject(items, forKey: "ChecklistItems")
    archiver.finishEncoding()
    
    // save to file
    data.writeToFile(dataFilePath(), atomically: true)
  }
  
  func loadCheckistItems() {
    let path =  dataFilePath()
    // check for existing file
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      // load data from file and if successful populate items array
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        items = unarchiver.decodeObjectForKey("ChecklistItems") as! [ChecklistItem]
        unarchiver.finishDecoding()
      }
    }
  }
  // -------------------------------------------------- DELEGATE
  func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem){
    if let index = items.indexOf(item) {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        configureTextForCell(cell, withCheckItem: item)
      }
    }
    dismissViewControllerAnimated(true, completion: nil)
    saveCheclistItems()
  }
  
  func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
    let newRowIndex = items.count
    
    items.append(item)
    
    let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
    let indexPaths = [indexPath]
    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    
    dismissViewControllerAnimated(true, completion: nil)
    saveCheclistItems()
  }
  
}

