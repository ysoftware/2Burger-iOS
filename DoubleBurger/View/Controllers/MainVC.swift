//
//  NewsVC.swift
//  DoubleBurger
//
//  Created by ysoftware on 18.07.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit
import MVVM

final class MainViewController: UIViewController {

	private let tableView = UITableView()
	
	private let viewModel = OffersVM()
	private var viewModelUpdateHandler:ArrayViewModelUpdateHandler!

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		setupViewModel()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		presentCitiesVCIfNeeded()
	}

	private func setupViewModel() {
		viewModelUpdateHandler = ArrayViewModelUpdateHandler(with: tableView)
		viewModel.delegate = self
		viewModel.reloadData()
	}

	private func setupTableView() {
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.leadingAnchor(equalTo: view.leadingAnchor)
			.trailingAnchor(equalTo: view.trailingAnchor)
			.topAnchor(equalTo: view.topAnchor)
			.bottomAnchor(equalTo: view.bottomAnchor)

		tableView.register(R.nib.offerCell(),
						   forCellReuseIdentifier: R.reuseIdentifier.offerCell.identifier)
		tableView.delegate = self
		tableView.dataSource = self
	}

	private func presentCitiesVCIfNeeded() {
		if Settings.selectedPlace == nil {
			present(CitiesViewController().inNavigationController, animated: false)
		}
	}
}

extension MainViewController: UITableViewDataSource {

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

extension MainViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

	}
}

extension MainViewController: ArrayViewModelDelegate {

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
