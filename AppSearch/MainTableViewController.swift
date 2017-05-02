//
//  MainTableViewController.swift
//  AppSearch
//
//  Created by Rickey Hrabowskie on 4/30/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemHandlerSharedInstance.items.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchableCell", for: indexPath) as! MainTableViewCell
    
    // Configure the cell...
    let item = itemHandlerSharedInstance.items[indexPath.row]
    cell.searchableItem = item
    
    return cell
  }
  
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "segueToDetail" {
      if let viewController = segue.destination as? DetailTableViewController, let searchableItem = (sender as? MainTableViewCell)?.searchableItem {
        viewController.searchableItem = searchableItem
      }
    }
  }
  
}
