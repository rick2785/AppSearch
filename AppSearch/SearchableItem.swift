//
//  SearchableItem.swift
//  AppSearch
//
//  Created by Rickey Hrabowskie on 4/30/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import Foundation
import UIKit
import CoreSpotlight
import MobileCoreServices

class SearchableItem {
  
  var id: String
  var name: String
  var phone: String
  var link: String
  var thumbnail: UIImage
  var summary: String
  var keywords: [String]
  
  init(dict: [String:String]) {
    id = dict["id"] ?? "000"
    name = dict["name"] ?? "empty"
    phone = dict["phone"] ?? "(000)-000-0000"
    link = dict["link"] ?? "empty"
    thumbnail = UIImage(named: (dict["thumbnail"] ?? "general.pdf")) ?? UIImage(named: "general.pdf")!
    summary = dict["summary"] ?? "empty"
    keywords = (dict["keywords"] ?? "empty").components(separatedBy: ",")
  }
  
  var userInfo: [String: String] {
    return ["id": id]
  }
  
  var userActivity: NSUserActivity {
    let activity = NSUserActivity(activityType: searchIdentifier)
    activity.title = name
    activity.userInfo = userInfo
    activity.keywords = Set(keywords)
    
    activity.contentAttributeSet = attributeSet
    return activity
  }
  
  var attributeSet: CSSearchableItemAttributeSet {
    let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeContent as String)
    attributeSet.title = name
    attributeSet.contentDescription = summary
    attributeSet.keywords = keywords
    attributeSet.url = URL(string: link)
    
    attributeSet.thumbnailData = UIImagePNGRepresentation(thumbnail)
    attributeSet.supportsPhoneCall = true
    attributeSet.phoneNumbers = [phone]
    
    attributeSet.relatedUniqueIdentifier = id
    
    return attributeSet
  }
  
  var searchableItem: CSSearchableItem {
    let item = CSSearchableItem(uniqueIdentifier: id, domainIdentifier: searchIdentifier, attributeSet: attributeSet)
    return item
  }
  
}
