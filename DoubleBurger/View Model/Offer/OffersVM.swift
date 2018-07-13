//
//  OffersVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM

final class OffersVM: ArrayViewModel<Offer, OfferVM, PaginationQuery> {

	override func fetchData(_ query: PaginationQuery?,
							_ block: @escaping ([Offer], Error?) -> Void) {
		guard let query = query else { return }
		Api.getOffers(with: query) { results, cursor, error in
			block(results, error)
			query.cursor = cursor
		}
	}
}
