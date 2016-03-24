//
//  ChecklistItem.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-09.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  var dueDate = NSDate()
  var shouldRemind = false
  var itemId: Int
  
  func toggleChecked() {
    checked = !checked
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    // items to encode
    aCoder.encodeObject(text, forKey: "Text")
    aCoder.encodeBool(checked, forKey: "Checked")
    aCoder.encodeObject(dueDate, forKey: "DueDate")
    aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
    aCoder.encodeInteger(itemId, forKey: "ItemId")
  }
  
  required init?(coder aDecoder: NSCoder) {
    text = aDecoder.decodeObjectForKey("Text") as! String
    checked = aDecoder.decodeBoolForKey("Checked")
    dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
    shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
    itemId = aDecoder.decodeIntegerForKey("ItemId")
    super.init()
  }
  
  override init() {
    itemId = DataModel.nextChecklistItemID()
    super.init()
  }
}