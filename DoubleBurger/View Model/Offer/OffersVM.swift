//
//  OffersVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM
import Result

final class OffersVM: ArrayViewModel<Offer, OfferVM, PaginationQuery> {

	override init() {
		super.init()
		self.query = PaginationQuery()
	}

	override func fetchData(_ query: PaginationQuery?,
							_ block: @escaping (Result<[Offer], AnyError>) -> Void) {
		guard let query = query else { return }
		Api.getOffers(with: query) { result in
			switch result {
			case .success(let response):
				query.cursor = response.cursor
				block(.success(response.items))
			case .failure(let error):
				block(.failure(AnyError(error)))
			}
		}
	}
}
