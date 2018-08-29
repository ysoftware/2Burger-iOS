//
//  Offer.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import Foundation

final class Offer: Codable {

	var id = ""
	var title = ""
	var timestamp:Double = 0
	var isActive:Bool? = false

	var promoCode:String? = ""
	var oldPrice:String? = ""
	var newPrice:String? = ""
}

extension Offer: Equatable {

	static func == (lhs: Offer, rhs: Offer) -> Bool {
		return lhs.id == rhs.id
	}
}
