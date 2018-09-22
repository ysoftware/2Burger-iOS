//
//  PlaceVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import CoreLocation
import MVVM

final class PlaceVM:ViewModel<Place> {

	func load(id:String) {
		Api.getPlace(id: id) { place in
			self.model = place
			self.notifyUpdated()
		}
	}

	var id:String {
		return model?.id ?? ""
	}

	var phoneNumberRaw: String {
		return model?.phoneNumber ?? ""
	}

	var location:CLLocation {
		guard let loc = model?.location else { return CLLocation() }
		return CLLocation(latitude: loc.latitude, longitude: loc.longitude)
	}

	// MARK: - View properties

	var name: String {
		return model?.name ?? ""
	}

	var phoneNumber: String {
		return format(phoneNumber: model?.phoneNumber ?? "")
	}

	var address: String {
		return model?.address ?? ""
	}
}
