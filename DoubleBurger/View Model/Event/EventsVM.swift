//
//  EventsVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM

final class EventsVM: ArrayViewModel<Event, EventVM, PaginationQuery> {

	override func fetchData(_ query: PaginationQuery?,
							_ block: @escaping (Result<[Event]>) -> Void) {
		guard let query = query else { return }
		Api.getEvents(with: query) { result in
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
