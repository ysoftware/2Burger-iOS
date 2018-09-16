//
//  Event.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import Foundation

final class Event: Codable {

	var id = ""
	var timestamp:Double = 0
	
	var title:String?
	var text:String?
}

extension Event: Equatable {

	static func == (lhs: Event, rhs: Event) -> Bool {
		return lhs.id == rhs.id
	}
}
