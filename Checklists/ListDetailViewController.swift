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

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
  
  // UI refrances
  @IBOutlet weak var textFeild: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var iconImageView: UIImageView!
  
  weak var delegate: ListDetailViewContollerDelegate?
  
  // instance variables
  var checklistToEdit: Checklist?
  var iconName = "Folder"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // check for ChecklistItem to be edited
    // and update UI
    if let checklist = checklistToEdit {
      title = "Edit Checklist"
      textFeild.text = checklist.name
      doneBarButton.enabled = true
      iconName = checklist.iconName
    }
    
    iconImageView.image = UIImage(named: iconName)
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
      checklist.iconName = iconName
      delegate?.listDetailViewController(self, didFinishEditingChecklist: checklist)
    } else {
      let checklist = Checklist(name: textFeild.text!)
      checklist.iconName = iconName
      delegate?.listDetailViewController(self, didFinishAddingChecklist: checklist)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "PickIcon" {
      let controller = segue.destinationViewController as! IconPickerViewController
      controller.delegate = self
    }
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    if indexPath.section == 1 {
      // 1 == icon picker
      return indexPath
    } else {
      // disable the ability to click on the cell directly
      return nil
    }
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    let oldText: NSString = textFeild.text!
    let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
    
    // emable done button only when there is text
    doneBarButton.enabled = (newText.length > 0)
    return true
  }
  
  func iconPicker(picker: IconPickerViewController, didPickIcon iconName: String) {
    self.iconName = iconName
    iconImageView.image = UIImage(named: iconName)
    navigationController?.popViewControllerAnimated(true)
  }
}
