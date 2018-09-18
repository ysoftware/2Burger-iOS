//
//  Database.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import Firebase
import FirestoreHelper
import Result

struct Api {

	private init() { }

	// MARK: - Methods

	static func getEvents(with query: PaginationQuery,
						  _ completion: @escaping (Result<PaginatedResponse<[Event]>, FirestoreHelperError>)->Void) {
		let request = placeRef.collection(Keys.events).order(by: Keys.timestamp, descending: true)
		FirestoreHelper.getList(from: request,
						  cursor: query.cursor,
						  limit: query.size,
						  completion)
	}

	static func getOffers(with query: PaginationQuery,
						  _ completion: @escaping (Result<PaginatedResponse<[Offer]>, FirestoreHelperError>)->Void) {
		let request = placeRef.collection(Keys.offers).order(by: Keys.timestamp, descending: true)
		FirestoreHelper.getList(from: request,
								cursor: query.cursor,
								limit: query.size,
								completion)
	}

	static func getPlaces(_ completion: @escaping (Result<[Place], FirestoreHelperError>)->Void) {
		FirestoreHelper.getList(from: placesRef, completion)
	}

	static func getPlace(id:String, _ completion: @escaping (Place?)->Void) {
		FirestoreHelper.get(from: placesRef.document(id)) {
			(result:Result<Place, FirestoreHelperError>) in
			switch result {
			case .success(let place): completion(place)
			case .failure(_): completion(nil)
			}
		}
	}
}

extension Api {

	static var placeRef: DocumentReference {
		let placeId = Settings.selectedPlace ?? Keys.defaultId
		return placesRef.document(placeId)
	}

	static var placesRef: CollectionReference {
		return FirestoreHelper.ref(Keys.places)
	}
}

extension Api {

	struct Keys {

		static let events = "events"
		static let offers = "offers"
		static let places = "cities"
		static let timestamp = "timestamp"
		static let defaultId = "ramenskoe"
	}
}
