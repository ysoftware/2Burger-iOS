//
//  Place.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import Foundation
import FirestoreHelper
import FirebaseFirestore

final class Place: Codable {

	var id = ""
	var name = ""
	var address = ""
	var phoneNumber = ""
	var location = Location(latitude: 0, longitude: 0)

	var social:[String:String]?
}

extension Place: Equatable {

	static func == (lhs: Place, rhs: Place) -> Bool {
		return lhs.id == rhs.id
	}
}
