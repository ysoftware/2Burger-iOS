//
//  Presenter.swift
//  DoubleBurger
//
//  Created by ysoftware on 16.09.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit

final class Presenter {

	static func presentCities(in viewController:UIViewController, animated:Bool = true) {
		let vc = R.storyboard.city.cityController()!.inNavigationController
		viewController.present(vc, animated: animated)
	}
}
