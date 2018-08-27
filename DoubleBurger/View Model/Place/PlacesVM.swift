//
//  PlacesVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM
import Result

final class PlacesVM: SimpleArrayViewModel<Place, PlaceVM> {

	override func fetchData(_ block: @escaping (Result<[Place], AnyError>) -> Void) {
		Api.getPlaces { result in
			switch result {
			case .success(let data): block(.success(data))
			case .failure(let error): block(.failure(AnyError(error)))
			}
		}
	}
}
