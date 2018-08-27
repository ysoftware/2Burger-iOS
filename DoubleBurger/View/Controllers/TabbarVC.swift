//
//  TabbarVC.swift
//  DoubleBurger
//
//  Created by ysoftware on 16.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit

final class TabbarVC: UITabBarController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		if Settings.selectedPlace == nil {
			present(R.storyboard.city.cityController()!.inNavigationController,
					animated: false)
		}
	}
}
