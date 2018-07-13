//
//  PlaceVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM

final class PlaceVM:ViewModel<Place> {

	var id:String {
		return model?.id ?? ""
	}

	// MARK: - View properties

	var name: String {
		return model?.name ?? ""
	}

	var phoneNumber: String {
		return model?.phoneNumber ?? ""
	}

	var address: String {
		return model?.address ?? ""
	}
}
