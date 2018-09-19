//
//  OfferVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM
import SDWebImage
import FirebaseUI
import UIKit

final class OfferVM:ViewModel<Offer> {

	var id:String {
		return model?.id ?? ""
	}

	// MARK: - View properties

	var title: String {
		return model?.title?.replacingOccurrences(of: "\\n", with: "\n") ?? ""
	}

	var text: String {
		return model?.text?.replacingOccurrences(of: "\\n", with: "\n") ?? ""
	}

	var promoCode: String {
		return model?.promoCode?.replacingOccurrences(of: "\\n", with: "\n") ?? ""
	}

	var oldPrice: String {
		return model?.oldPrice ?? ""
	}

	var newPrice: String {
		return model?.newPrice ?? ""
	}

	var shouldCrossOldPrice:Bool {
		return model?.oldPrice != nil
	}

	func setImage(into imageView:UIImageView) {
		guard let id = model?.id else { return }
		let ref = Storage.storage().reference(withPath: "offers/\(id).jpg")
		imageView.sd_setImage(with: ref)
	}
}
