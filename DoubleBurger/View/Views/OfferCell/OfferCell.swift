//
//  OfferCell.swift
//  DoubleBurger
//
//  Created by ysoftware on 18.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit

final class OfferCell: UITableViewCell {

	@IBOutlet weak var newsImage:UIImageView!
	@IBOutlet weak var titleLabel:UILabel!
	@IBOutlet weak var contentLabel:UILabel!

	func setup(with model:OfferVM) -> OfferCell {

		model.setImage(into: newsImage)
		titleLabel.text = model.title
		contentLabel.text = model.text

		return self
	}
}
