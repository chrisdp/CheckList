//
//  ChecklistItem.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-09.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import Foundation
import UIKit

class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  var dueDate = NSDate()
  var shouldRemind = false
  var itemId: Int
  
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
  
  func toggleChecked() {
    checked = !checked
  }
  
  func scheduleNotification() {
    if shouldRemind && dueDate.compare(NSDate()) != .OrderedAscending {
      
      let localNotification = UILocalNotification()
      localNotification.fireDate = dueDate
      localNotification.timeZone = NSTimeZone.defaultTimeZone()
      localNotification.alertBody = text
      localNotification.soundName = UILocalNotificationDefaultSoundName
      localNotification.userInfo = ["ItemID": itemId]
      
      UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

      print("Scheduled notification \(localNotification) for itemID \(itemId)")
    }
  }
}