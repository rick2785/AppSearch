//
//  DetailTableViewController.swift
//  AppSearch
//
//  Created by Rickey Hrabowskie on 4/30/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
  
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var btnPhone: UIButton!
  @IBOutlet weak var btnLink: UIButton!
  @IBOutlet weak var imgThumbnail: UIImageView!
  @IBOutlet weak var txtSummary: UITextView!
  
  var searchableItem: SearchableItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    lblName.text = searchableItem.name
    btnPhone.setTitle(searchableItem.phone, for: UIControlState())
    btnLink.setTitle(searchableItem.link, for: UIControlState())
    imgThumbnail.image = searchableItem.thumbnail
    txtSummary.text = searchableItem.summary
    
    let activity = searchableItem.userActivity
    switch Setting.searchIndexingPreference {
    case .disabled:
      activity.isEligibleForSearch = false
    case .viewedRecords:
      activity.isEligibleForSearch = true
      
      // If not indexed in Core Spotlight, must set relatedUniqueIdentifier = nil
      activity.contentAttributeSet?.relatedUniqueIdentifier = nil
    case .allRecords:
      activity.isEligibleForSearch = true
    }
    
    userActivity = activity
  }
  
  override func updateUserActivityState(_ activity: NSUserActivity) {
    activity.addUserInfoEntries(from: searchableItem.userInfo)
  }
  
  @IBAction func btnPhone_Pressed(_ sender: UIButton) {
    if let phone = searchableItem?.phone, let url = URL(string: "tel:\(phone)") {
      UIApplication.shared.openURL(url)
    }
  }
  
  @IBAction func btnLink_Pressed(_ sender: UIButton) {
    if let link = searchableItem?.link, let url = URL(string: link) {
      UIApplication.shared.openURL(url)
    }
  }
  
}
