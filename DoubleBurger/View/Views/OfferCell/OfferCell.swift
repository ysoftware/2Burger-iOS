//
//  OfferCell.swift
//  DoubleBurger
//
//  Created by ysoftware on 18.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit

final class OfferCell: UICollectionViewCell {

	@IBOutlet weak var newsImage:UIImageView!
	@IBOutlet weak var titleLabel:UILabel!
//	@IBOutlet weak var contentLabel:UILabel!

	func setup(with vm:OfferVM) -> OfferCell {

		vm.setImage(into: newsImage)
		titleLabel.text = vm.title
//		contentLabel.text = model.text

		return self
	}
}
