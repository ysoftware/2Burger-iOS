//
//  NewsVC.swift
//  DoubleBurger
//
//  Created by ysoftware on 18.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit
import MVVM

final class OffersViewController: UIViewController {

	@IBOutlet weak var tableView:UITableView!

	let viewModel = OffersVM()
	var viewModelUpdateHandler:ArrayViewModelUpdateHandler!

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(R.nib.offerCell(),
						   forCellReuseIdentifier: R.reuseIdentifier.offerCell.identifier)

		viewModelUpdateHandler = ArrayViewModelUpdateHandler(with: tableView)
		viewModel.delegate = self
		viewModel.reloadData()
	}
}

extension OffersViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfItems
	}

	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.offerCell.identifier,
												 for: indexPath) as! OfferCell
		return cell.setup(with: viewModel.item(at: indexPath.row))
	}
}

extension OffersViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

	}
}

extension OffersViewController: ArrayViewModelDelegate {

	func didChangeState(to state: ArrayViewModelState) {
		switch state {
		case .error(let error):
			call(message: error.localizedDescription)
		default:
			break
		}
	}

	func didUpdateData<M, VM, Q>(_ arrayViewModel: ArrayViewModel<M, VM, Q>,
								 _ update: Update)
		where M : Equatable, VM : ViewModel<M>, Q : Query {

			viewModelUpdateHandler.handle(update)
	}
}
