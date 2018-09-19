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

	private static func presenter(bounds:CGRect, percent:Float) -> Presentr {
		let margin = bounds.height * CGFloat(1 - percent)
		let	top = bounds.height / 2 + margin / 2
		let centerPoint = CGPoint(x: bounds.width / 2,
								  y: top)

		let type = PresentationType.custom(width: .full,
										   height: .fluid(percentage: percent),
										   center: .custom(centerPoint: centerPoint))
		let presenter = Presentr(presentationType: type)
		presenter.blurBackground = false
		presenter.roundCorners = true
		presenter.backgroundColor = .black
		presenter.backgroundOpacity = 0.5
		return presenter
	}

	static func presentCities(in viewController:UIViewController, animated:Bool = true) {
		let vc = R.storyboard.main.cityController()!.inNavigationController
		viewController.present(vc, animated: animated)
	}

	static func presentContacts(in viewController:UIViewController) {
		let vc = R.storyboard.main.contactsViewController()!
		let p = presenter(bounds: viewController.view.bounds, percent: 0.8)
		viewController.customPresentViewController(p, viewController: vc, animated: true)
	}

	static func presentOffer(_ offerVM:OfferVM, in viewController:UIViewController) {
		let vc = R.storyboard.main.codeVC()!
		vc.offerVM = offerVM
		let p = presenter(bounds: viewController.view.bounds, percent: 0.5)
		viewController.customPresentViewController(p, viewController: vc, animated: true)
	}

	static func presentEvent(_ eventVM:EventVM, in viewController:UIViewController) {
		let vc = R.storyboard.main.codeVC()!
		vc.eventVM = eventVM
		let p = presenter(bounds: viewController.view.bounds, percent: 0.8)
		viewController.customPresentViewController(p, viewController: vc, animated: true)
	}
}
