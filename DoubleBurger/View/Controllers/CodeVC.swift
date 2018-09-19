//
//  CodeVC.swift
//  DoubleBurger
//
//  Created by ysoftware on 03.09.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit

final class CodeVC: UIViewController {

	// MARK: - Outlets

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var offerImage: UIImageView!
	@IBOutlet weak var descriptionLabel: UITextView!
	@IBOutlet weak var codeLabel: UILabel!

	// MARK: - Properties

	var offerVM:OfferVM?
	var eventVM:EventVM?

	// MARK: - View controller

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	func setup() {
		if let vm = self.offerVM {
			titleLabel.text = vm.title
			descriptionLabel.text = vm.text
			codeLabel.text = vm.promoCode
			vm.setImage(into: offerImage)
		}
		else if let vm = self.eventVM {
			titleLabel.text = vm.title
			descriptionLabel.text = vm.text
			codeLabel.isHidden = true
			vm.setImage(into: offerImage)
		}
	}
}
