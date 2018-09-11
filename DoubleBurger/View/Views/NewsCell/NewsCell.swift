//
//  NewsCell.swift
//  DoubleBurger
//
//  Created by ysoftware on 18.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit

final class NewsCell: UICollectionViewCell {

	@IBOutlet weak var newsImage:UIImageView!
	@IBOutlet weak var titleLabel:UILabel!

	func setup(with vm:EventVM) -> NewsCell {

		vm.setImage(into: newsImage)
		titleLabel.text = vm.text

		return self
	}
}
