//
//  FormatPhone.swift
//  DoubleBurger
//
//  Created by ysoftware on 21.09.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import Foundation

func format(phoneNumber source: String) -> String {
	let s = source.replacingOccurrences(of: "+7", with: "8")
	guard s.count == 11 else { return source }
	return String(format: "%@ (%@) %@-%@-%@",
				  s.substring(to: s.index(s.startIndex, offsetBy: 1)),
				  s.substring(with: s.index(s.startIndex, offsetBy: 1) ..< s.index(s.startIndex, offsetBy: 4)),
				  s.substring(with: s.index(s.startIndex, offsetBy: 4) ..< s.index(s.startIndex, offsetBy: 7)),
				  s.substring(with: s.index(s.startIndex, offsetBy: 7) ..< s.index(s.startIndex, offsetBy: 9)),
				  s.substring(with: s.index(s.startIndex, offsetBy: 9) ..< s.index(s.startIndex, offsetBy: 11))
	)
}
