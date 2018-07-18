//
//  ViewController.swift
//  DoubleBurger
//
//  Created by ysoftware on 13.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit
import MVVM

final class CitiesViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	let viewModel = PlacesVM()
	var viewModelUpdateHandler:ArrayViewModelUpdateHandler!
	var refreshControl = UIRefreshControl()
	var selectedIndex = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(R.nib.cityCell(),
						   forCellReuseIdentifier: R.reuseIdentifier.cityCell.identifier)
		tableView.refreshControl = refreshControl

		viewModelUpdateHandler = ArrayViewModelUpdateHandler(with: tableView)
		viewModel.delegate = self
		viewModel.reloadData()
	}
}

extension CitiesViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfItems
	}

	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cityCell.identifier,
												 for: indexPath) as! CityCell
		return cell.setup(with: viewModel.item(at: indexPath.row))
	}
}

extension CitiesViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let city = viewModel.item(at: indexPath.row)
		Settings.set(selectedPlace: city.id)
		dismiss()
	}
}

extension CitiesViewController: ArrayViewModelDelegate {

	func didChangeState(to state: ArrayViewModelState) {
		refreshControl.endRefreshing()

		switch state {
		case .loading:
			refreshControl.beginRefreshing()
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
