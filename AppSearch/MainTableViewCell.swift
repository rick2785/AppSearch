//
//  MainTableViewCell.swift
//  AppSearch
//
//  Created by Rickey Hrabowskie on 4/30/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
  
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var imgThumbnail: UIImageView!
  @IBOutlet weak var txtSummary: UITextView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  var searchableItem: SearchableItem? {
    didSet {
      if let searchableItem = searchableItem {
        lblName.text = searchableItem.name
        txtSummary.text = searchableItem.summary
        imgThumbnail.image = searchableItem.thumbnail
      }
    }
  }
  
}
