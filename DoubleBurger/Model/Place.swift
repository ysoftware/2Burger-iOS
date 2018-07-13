//
//  Place.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import Foundation

final class Place: Codable {

	var id = ""
	var name = ""
	var address = ""
	var phoneNumber = ""

	var social:[String:String]?
}

extension Place: Equatable {

	static func == (lhs: Place, rhs: Place) -> Bool {
		return lhs.id == rhs.id
	}
}
