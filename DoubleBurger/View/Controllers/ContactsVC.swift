//
//  ContactsVC.swift
//  DoubleBurger
//
//  Created by ysoftware on 16.09.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit

final class ContactsViewController: UIViewController {

	// MARK: - Outlets

	@IBOutlet weak var phoneNumberLabel: UILabel!

	// MARK: - Actions

	@IBAction func vkTapped(_ sender: Any) {
		Presenter.presentApp(in: self,
							 appURLString: "vk://vk.com/2burger",
							 safariURLString: "https://vk.com/2burger")
	}

	@IBAction func igTapped(_ sender: Any) {
		Presenter.presentApp(in: self,
							 appURLString: "instagram://user?username=2burger.ru",
							 safariURLString: "https://www.instagram.com/2burger.ru/")
	}

	@IBAction func fbTapped(_ sender: Any) {
		Presenter.presentApp(in: self,
							 appURLString: "fb://profile/1775995646061900",
							 safariURLString: "https://www.facebook.com/2burger.ru")
	}

	@IBAction func phoneTapped(_ sender: Any) {
		let phoneNumber = "tel://\(placeVM.phoneNumberRaw)"
		UIApplication.shared.open(URL(string: phoneNumber)!, options: [:], completionHandler: nil)

	}

	@IBAction func mailTapped(_ sender: Any) {
		Presenter.presentEmailViewController(in: self)
	}

	@IBAction func mapTapped(_ sender: Any) {

	}

	// MARK: - Properties

	var placeVM:PlaceVM!

	// MARK: - Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	func setup() {
		phoneNumberLabel.text = placeVM.phoneNumber
	}
}
