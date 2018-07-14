//
//  OfferVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM
import SDWebImage
import UIKit

final class OfferVM:ViewModel<Offer> {

	var id:String {
		return model?.id ?? ""
	}

	// MARK: - View properties

	var title: String {
		return model?.title ?? ""
	}

	var text: String {
		return model?.text ?? ""
	}

	func setImage(into imageView:UIImageView) {
		guard let urlString = model?.imageUrl, let url = URL(string: urlString) else { return }
		imageView.sd_setImage(with: url)
	}
}
