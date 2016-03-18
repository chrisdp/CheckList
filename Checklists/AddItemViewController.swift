//
//  AddItemViewController.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-11.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  
  @IBAction func cancel(){
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func done() {
    print("Contents of the text field: \(textField.text!)")
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    let oldText: NSString = textField.text!
    let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
    
    doneBarButton.enabled = newText.length > 0
    
    return true
  }
  
}
