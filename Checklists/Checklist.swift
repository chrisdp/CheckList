//
//  Checklist.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-21.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
  var name = ""
  var items = [ChecklistItem]()
  
  init(name: String) {
    self.name = name
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey("Name") as! String
    items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
    super.init()
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: "Name")
    aCoder.encodeObject(items, forKey: "Items")
  }
  
  func countUncheckedItems() -> Int {
    var count = 0
    // count the number of checked off items
    for item in items where !item.checked {
      count++
    }
    return count
  }
}
