//
//  CityCell.swift
//  DoubleBurger
//
//  Created by ysoftware on 16.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit

final class CityCell: UITableViewCell {

	@IBOutlet weak var nameLabel:UILabel!
	
	func setup(with model:PlaceVM) -> CityCell {
		
		nameLabel.text = model.name

		return self
	}
}
