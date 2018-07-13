//
//  PlacesVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM

final class PlacesVM: SimpleArrayViewModel<Place, PlaceVM> {

	override func fetchData(_ block: @escaping ([Place], Error?) -> Void) {
		Api.getPlaces(block)
	}
}
