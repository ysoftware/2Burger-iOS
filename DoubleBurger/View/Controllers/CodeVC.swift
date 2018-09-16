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

	var offerVM:OfferVM!

	// MARK: - View controller

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	func setup() {
		titleLabel.text = offerVM.title
		descriptionLabel.text = offerVM.description
		codeLabel.text = offerVM.promoCode
		offerVM.setImage(into: offerImage)
	}
}
