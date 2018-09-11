//
//  OfferCell.swift
//  DoubleBurger
//
//  Created by ysoftware on 18.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit

final class OfferCell: UICollectionViewCell {

	@IBOutlet weak var diagonalImage: UIImageView!
	@IBOutlet weak var backgroundRight: UIView!
	@IBOutlet weak var newsImage:UIImageView!
	@IBOutlet weak var titleLabel:UILabel!
	@IBOutlet weak var oldPriceLabel: UILabel!
	@IBOutlet weak var newPriceLabel: UILabel!

	func setup(with vm:OfferVM) -> OfferCell {

		vm.setImage(into: newsImage)
		titleLabel.text = vm.title
		oldPriceLabel.text = vm.oldPrice
		newPriceLabel.text = vm.newPrice

		color = .yellow
		textColor = .black
		return self
	}

	var color:UIColor = .white {
		didSet {
			diagonalImage.tintColor = color
			backgroundRight.backgroundColor = color
		}
	}

	var textColor:UIColor = .black {
		didSet {
			titleLabel.textColor = textColor
			oldPriceLabel.textColor = textColor
			newPriceLabel.textColor = textColor
		}
	}
}
