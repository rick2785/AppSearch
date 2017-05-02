//
//  ItemHandler.swift
//  AppSearch
//
//  Created by Rickey Hrabowskie on 4/30/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import Foundation
import CoreSpotlight

let searchIdentifier = "com.raywenderlich.appSearch"
let itemHandlerSharedInstance = ItemHandler()

class ItemHandler {
  
  var items = [SearchableItem]()
  
  init() {
    loadJSON()
  }
  
  fileprivate func loadJSON() {
    // Load local JSON file
    if let path = Bundle.main.path(forResource: "Items", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.uncached)
        let records = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String: String]]
        
        items = [SearchableItem]()
        for record in records {
          let item = SearchableItem(dict: record)
          items.append(item)
        }
      } catch let error as NSError {
        print("JSON error: \(error)")
      }
    }
  }
  
  func itemWithObjectId(_ id: String) -> SearchableItem? {
    let filtered = items.filter { $0.id == id }
    return filtered.first
  }
  
  func indexAllItems() {
    let searchableItems = items.map { $0.searchableItem }
    CSSearchableIndex.default().indexSearchableItems(searchableItems) { error in
        if let error = error {
          print("Error indexing: \(error)")
        } else {
          print("Indexed.")
        }
    }
  }
  
  func destroyAllIndexing() {
    CSSearchableIndex.default().deleteAllSearchableItems { error in
        if let error = error {
          print("Error deleting indexed items: \(error)")
        } else {
          print("Indexing deleted.")
        }
    }
  }
  
}
