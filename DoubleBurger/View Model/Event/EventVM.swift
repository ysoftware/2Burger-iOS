//
//  EventVM.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import MVVM
import UIKit
import FirebaseUI
import SDWebImage

final class EventVM:ViewModel<Event> {

	var id:String {
		return model?.id ?? ""
	}

	// MARK: - View properties

	var title: String {
		return model?.title ?? ""
	}

	var date: String {
		guard let timestamp = model?.timestamp else { return "" }
		let date = Date(timeIntervalSince1970: timestamp)
		return "\(date)"
	}

	var text: String {
		return model?.text ?? ""
	}

	func setImage(into imageView:UIImageView) {
		guard let id = model?.id else { return }
		let ref = Storage.storage().reference(withPath: "images/" + id)
		imageView.sd_setImage(with: ref)
	}
}
