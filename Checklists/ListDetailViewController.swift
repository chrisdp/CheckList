//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-21.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import UIKit

// custom delegate
protocol ListDetailViewContollerDelegate: class {
  func listDetailViewControllerDidCancel(controller: ListDetailViewController)
  func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)
  func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
  
  // UI refrances
  @IBOutlet weak var textFeild: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  weak var delegate: ListDetailViewContollerDelegate?
  
  // instance variables
  var checklistToEdit: Checklist?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // check for ChecklistItem to be edited
    // and update UI
    if let checklist = checklistToEdit {
      title = "Edit Checklist"
      textFeild.text = checklist.name
      doneBarButton.enabled = true
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    // set appear animation and first responder
    super.viewWillAppear(animated)
    textFeild.becomeFirstResponder()
  }
  
  // -------------------------------------------------- EVENT HANLDERS
  @IBAction func cancel() {
    delegate?.listDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    // check to see if ChecklistItem was passed in for editing
    // or create a new one
    if let checklist = checklistToEdit {
      checklist.name = textFeild.text!
      delegate?.listDetailViewController(self, didFinishEditingChecklist: checklist)
    } else {
      let checklist = Checklist(name: textFeild.text!)
      delegate?.listDetailViewController(self, didFinishAddingChecklist: checklist)
    }
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    // disable the ability to click on the cell directly
    return nil
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    let oldText: NSString = textFeild.text!
    let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
    
    // emable done button only when there is text
    doneBarButton.enabled = (newText.length > 0)
    return true
  }
}
