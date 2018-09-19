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

	// MARK: - Outlets

	@IBOutlet weak var cityButton: UIButton!
	@IBOutlet weak var newsCollectionView:UICollectionView!
	@IBOutlet weak var offersCollectionView:UICollectionView!

	// MARK: - Properties

	let placeVM = PlaceVM()
	let offersVM = OffersVM()
	let newsVM = EventsVM()
	var newsVMUpdater:ArrayViewModelUpdateHandler!
	var offersVMUpdater:ArrayViewModelUpdateHandler!

	var loadedPlace:String?

	// MARK: - Actions

	@IBAction func contactsTapped(_ sender: Any) {
		Presenter.presentContacts(in: self)
	}

	@IBAction func cityTapped(_ sender: Any) {
		Presenter.presentCities(in: self)
	}

	// MARK: - Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		if Settings.selectedPlace == nil {
			Presenter.presentCities(in: self, animated: false)
		}
		else if loadedPlace != Settings.selectedPlace {
			loadedPlace = Settings.selectedPlace
			setupCollectionViews()
			setupCity()
		}
	}

	private func setup() {
		placeVM.delegate = self

		offersCollectionView.register(R.nib.offerCell(),
									  forCellWithReuseIdentifier: R.reuseIdentifier.offerCell.identifier)

		newsCollectionView.register(R.nib.newsCell(),
									forCellWithReuseIdentifier: R.reuseIdentifier.newsCell.identifier)
	}

	private func setupCity() {
		guard let id = Settings.selectedPlace else { return }
		placeVM.load(id: id)
	}

	private func setupCollectionViews() {
		offersVMUpdater = ArrayViewModelUpdateHandler(with: offersCollectionView)
		offersVM.delegate = self
		offersVM.reloadData()

		newsVMUpdater = ArrayViewModelUpdateHandler(with: newsCollectionView)
		newsVM.delegate = self
		newsVM.reloadData()
	}
}

extension MainViewController: ViewModelDelegate {

	func didUpdateData<M>(_ viewModel: ViewModel<M>) where M : Equatable {
		if viewModel is PlaceVM {
			cityButton.setTitle(placeVM.name, for: .normal)
		}
	}
}

extension MainViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		if collectionView == offersCollectionView {
			return offersVM.numberOfItems
		}
		return newsVM.numberOfItems
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == offersCollectionView {
			return (collectionView
				.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.offerCell.identifier,
									 for: indexPath) as! OfferCell)
				.setup(with: offersVM.item(at: indexPath.row))
		}

		return (collectionView
			.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.newsCell.identifier,
								 for: indexPath) as! NewsCell)
			.setup(with: newsVM.item(at: indexPath.row))
	}
}

extension MainViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView,
						didSelectItemAt indexPath: IndexPath) {
		if collectionView == offersCollectionView {
			Presenter.presentOffer(offersVM.item(at: indexPath.row), in: self)
		}
		else {
			Presenter.presentEvent(newsVM.item(at: indexPath.row), in: self)
		}
	}
}

extension MainViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let format:CGFloat = collectionView == newsCollectionView ? 1.75 : 1.8
		let width = collectionView.bounds.width - 30
		let height = width / format
		return CGSize(width: width, height: height)
	}
}

extension MainViewController: ArrayViewModelDelegate {

	func didChangeState(to state: ArrayViewModelState) {
		switch state {
		case .error(_):
			call(message: "Произошла ошибка. Пожалуйста, повторите позже.")
		default:
			break
		}
	}

	func didUpdateData<M, VM, Q>(_ arrayViewModel: ArrayViewModel<M, VM, Q>,
								 _ update: Update)
		where M : Equatable, VM : ViewModel<M>, Q : Query {

			if arrayViewModel === offersVM {
				offersVMUpdater.handle(update)
			}
			else {
				newsVMUpdater.handle(update)
			}
	}
}
