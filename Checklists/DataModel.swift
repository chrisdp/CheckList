//
//  DataModel.swift
//  Checklists
//
//  Created by christopher dwyer-perkins on 2016-03-22.
//  Copyright © 2016 christopher dwyer-perkins. All rights reserved.
//

import Foundation

class DataModel {
  var lists = [Checklist]()
  
  init() {
    loadCheckists()
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
  
  func saveCheclists() {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    
    // encode array into writable binary data
    archiver.encodeObject(lists, forKey: "Checklists")
    archiver.finishEncoding()
    
    // save to file
    data.writeToFile(dataFilePath(), atomically: true)
  }
  
  func loadCheckists() {
    let path =  dataFilePath()
    // check for existing file
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      // load data from file and if successful populate items array
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        lists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
        unarchiver.finishDecoding()
      }
    }
  }
}