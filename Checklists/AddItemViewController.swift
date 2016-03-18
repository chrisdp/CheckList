//
//  AddItemViewController.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-11.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import Foundation
import UIKit

// custom delegate
protocol AddItemViewControllerDelegate: class {
  func addItemViewControllerDidCancel(controller: AddItemViewController)
  func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
  func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
  // instance variables
  weak var delegate: AddItemViewControllerDelegate?
  var itemToEdit: ChecklistItem?
  
  // UI refrances
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  override func viewWillAppear(animated: Bool) {
    // set appear animation and first responder
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // check for ChecklistItem to be edited
    // and update UI
    if let item = itemToEdit {
      title = "Edit Item"
      textField.text = item.text
      doneBarButton.enabled = true
    }
  }
  
  @IBAction func cancel(){
    delegate?.addItemViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    // check to see if ChecklistItem was passed in for editing
    // or create a new one
    if let item = itemToEdit {
      item.text = textField.text!
      delegate?.addItemViewController(self, didFinishEditingItem: item)
    } else {
      let item = ChecklistItem()
      item.text = textField.text!
      item.checked = false
      delegate?.addItemViewController(self, didFinishAddingItem: item)
    }
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    let oldText: NSString = textField.text!
    let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
    
    doneBarButton.enabled = (newText.length > 0)
    
    return true
  }
  
}
