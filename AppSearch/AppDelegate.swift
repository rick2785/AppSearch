//
//  AppDelegate.swift
//  AppSearch
//
//  Created by Rickey Hrabowskie on 4/30/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit
import CoreSpotlight

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    return true
  }
  
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    
    let itemId: String
    if userActivity.activityType == searchIdentifier, let id = userActivity.userInfo?["id"] as? String {
        // Indexed by NSUserActivity
        itemId = id
    } else if userActivity.activityType == CSSearchableItemActionType, let id = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
          // Indexed by CoreSpotlight
          itemId = id
    } else {
      return false
    }
    
    if let nav = window?.rootViewController as? UINavigationController, let allItemsView = nav.viewControllers.first as? MainTableViewController, let item = itemHandlerSharedInstance.itemWithObjectId(itemId) {
      nav.popToRootViewController(animated: false)
      let detailViewController = allItemsView.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailTableViewController
      detailViewController.searchableItem = item
      nav.pushViewController(detailViewController, animated: false)
      return true
    }
    return false
  }
  
}

