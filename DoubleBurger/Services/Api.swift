//
//  Database.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import Firebase
import FirestoreHelper

struct Api {

	private init() {}

	static func getEvents(with query: PaginationQuery,
						  _ completion: @escaping ([Event], DocumentSnapshot?, Error?)->Void) {
		let request = placeRef.collection(Keys.events).order(by: Keys.timestamp)
		FirestoreHelper.getList(from: request,
						  cursor: query.cursor,
						  limit: query.size) { (events:[Event], cursor, error) in
			completion(events, cursor, error)
		}
	}

	static func getOffers(with query: PaginationQuery,
						  _ completion: @escaping ([Offer], DocumentSnapshot?, Error?)->Void) {
		let request = placeRef.collection(Keys.offers).order(by: Keys.timestamp)
		FirestoreHelper.getList(from: request,
								cursor: query.cursor,
								limit: query.size) { (events:[Offer], cursor, error) in
									completion(events, cursor, error)
		}
	}

	static func getPlaces(_ completion: @escaping ([Place], Error?)->Void) {
		FirestoreHelper.getList(from: placesRef, completion)
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

extension Api {

	static var placeRef: DocumentReference {
		let placeId = Settings.selectedPlace ?? "ramenskoe"
		return placesRef.document(placeId)
	}

	static var placesRef: CollectionReference {
		return FirestoreHelper.ref(Keys.places)
	}
}
