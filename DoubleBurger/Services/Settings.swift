//
//  Settings.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import Foundation

/// Набор статических методов для работы с UserDefaults.
struct Settings {
	private init() {}

	/// Очистить все настройки пользователя
	public static func clear() {
		let domain = Bundle.main.bundleIdentifier!
		defaults.removePersistentDomain(forName: domain)
		checkFirstLaunch()
		defaults.synchronize()
	}

	static let defaults:UserDefaults = .standard

	/// Проверить, первый ли этот запуск.
	static var isFirstLaunch:Bool { return defaults.value(forKey: Keys.firstLaunch) == nil }

	/// Сохранить информацию о том, что первый запуск был совершен ранее.
	static func checkFirstLaunch() {
		defaults.set(true, forKey: Keys.firstLaunch)
	}
}

extension Settings {

	// MARK: - Выбранный город

	static var selectedPlace:String? {
		return defaults.string(forKey: Keys.placeId)
	}

	static func set(selectedPlace value:String) {
		defaults.set(value, forKey: Keys.placeId)
	}
}

extension Settings {
	struct Keys {
		static let firstLaunch = "firstLaunch"
		static let placeId = "placeId"
	}
}
