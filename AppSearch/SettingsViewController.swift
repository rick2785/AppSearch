//
//  SettingsViewController.swift
//  AppSearch
//
//  Created by Rickey Hrabowskie on 4/30/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	
	@IBOutlet weak var segmentIndexOptions: UISegmentedControl!
	@IBOutlet weak var txtIndexDescription: UITextView!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		segmentIndexOptions.selectedSegmentIndex = Setting.searchIndexingPreference.rawValue
		txtIndexDescription.text = Setting.searchIndexingPreference.description
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		switch Setting.searchIndexingPreference {
		case .disabled:
			itemHandlerSharedInstance.destroyAllIndexing()
		case .viewedRecords:
			break
		case .allRecords:
			itemHandlerSharedInstance.indexAllItems()
		}
	}
	
	@IBAction func segmentIndexOptions_Changed(_ sender: UISegmentedControl) {
		if let preference = SearchIndexingPreference(rawValue: segmentIndexOptions.selectedSegmentIndex) {
			Setting.searchIndexingPreference = preference
		} else {
			Setting.searchIndexingPreference = .disabled
		}
		
		txtIndexDescription.text = Setting.searchIndexingPreference.description
	}
}
