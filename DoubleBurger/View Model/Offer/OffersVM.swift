//
//  OffersVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM

final class OffersVM: ArrayViewModel<Offer, OfferVM, PaginationQuery> {

	override init() {
		super.init()
		self.query = PaginationQuery()
	}

	override func fetchData(_ query: PaginationQuery?,
							_ block: @escaping (Result<[Offer]>) -> Void) {
		guard let query = query else { return }
		Api.getOffers(with: query) { result in
			switch result {
			case .data(let data, let cursor):
				query.cursor = cursor
				block(.data(data))
			case .error(let error):
				block(.error(error))
			}
		}
	}
}
