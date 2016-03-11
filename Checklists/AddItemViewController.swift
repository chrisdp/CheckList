//
//  AddItemViewController.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-11.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UITableViewController {
  
  @IBAction func cancel(){
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func done() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
}
