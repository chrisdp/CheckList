//
//  Checklist.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-21.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import UIKit

class Checklist: NSObject {
  var name = ""
  
  init(name: String) {
    self.name = name
    super.init()
  }
}
