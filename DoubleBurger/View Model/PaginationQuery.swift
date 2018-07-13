//
//  PaginationQuery.swift
//  DoubleBurger
//
//  Created by ysoftware on 14.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM
import FirebaseFirestore
import FirestoreHelper

final class PaginationQuery: MVVM.Query {

	var cursor:DocumentSnapshot?

	func resetPosition() {
		cursor = nil
	}
}
