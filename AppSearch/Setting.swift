//
//  Setting.swift
//  AppSearch
//
//  Created by Rickey Hrabowskie on 4/30/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import Foundation

enum SearchIndexingPreference: Int {
  case disabled, viewedRecords, allRecords
	
	var description: String {
		switch self {
		case .disabled:
			return "No indexing will be performed."
		case .viewedRecords:
			return "Only records viewed by user will be indexed."
		case .allRecords:
			return "All records will be indexed."
		}
	}
}

private let searchPreferenceKey = "SearchIndexingPreference"

struct Setting {
	static var searchIndexingPreference: SearchIndexingPreference {
		get {
			let preferenceRawValue = UserDefaults.standard.integer(forKey: searchPreferenceKey)
			if let preference = SearchIndexingPreference(rawValue: preferenceRawValue) {
				return preference
			} else {
				return .disabled
			}
		}
		set {
			// Store
			UserDefaults.standard.set(newValue.rawValue, forKey: searchPreferenceKey)
			UserDefaults.standard.synchronize()
		}
	}
}
