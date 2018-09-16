//
//  Presenter.swift
//  DoubleBurger
//
//  Created by ysoftware on 16.09.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit
import Presentr

final class Presenter {

	private static func presenter(_ height:ModalSize) -> Presentr {
		let type = PresentationType.custom(width: .full, height: height, center: .bottomCenter)
		let presenter = Presentr(presentationType: type)
		presenter.blurBackground = false
		presenter.blurStyle = .light
		presenter.roundCorners = true
		presenter.backgroundColor = .white
		return presenter
	}

	static func presentCities(in viewController:UIViewController, animated:Bool = true) {
		let vc = R.storyboard.main.cityController()!.inNavigationController
		viewController.present(vc, animated: animated)
	}

	static func presentContacts(in viewController:UIViewController) {
		let vc = R.storyboard.main.contactsViewController()!
		let p = presenter(.full)
		viewController.customPresentViewController(p, viewController: vc, animated: true)
	}

	static func presentOffer(_ offerVM:OfferVM, in viewController:UIViewController) {
		let vc = R.storyboard.main.codeVC()!
		vc.offerVM = offerVM
		let p = presenter(.half)
		viewController.customPresentViewController(p, viewController: vc, animated: true)
	}
}
