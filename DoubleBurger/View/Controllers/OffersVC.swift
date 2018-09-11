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

	@IBOutlet weak var newsCollectionView:UICollectionView!
	@IBOutlet weak var offersCollectionView:UICollectionView!

	let offersVM = OffersVM()
	var offersVMUpdater:ArrayViewModelUpdateHandler!

	let newsVM = EventsVM()
	var newsVMUpdater:ArrayViewModelUpdateHandler!

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		if Settings.selectedPlace == nil {
			present(R.storyboard.city.cityController()!.inNavigationController,
					animated: false)
		}
		else if newsVMUpdater == nil {
			setupCollectionViews()
		}
	}

	private func setupCollectionViews() {
		offersCollectionView.register(R.nib.offerCell(),
									  forCellWithReuseIdentifier: R.reuseIdentifier.offerCell.identifier)

		newsCollectionView.register(R.nib.newsCell(),
									forCellWithReuseIdentifier: R.reuseIdentifier.newsCell.identifier)

		offersVMUpdater = ArrayViewModelUpdateHandler(with: offersCollectionView)
		offersVM.delegate = self
		offersVM.reloadData()

		newsVMUpdater = ArrayViewModelUpdateHandler(with: newsCollectionView)
		newsVM.delegate = self
		newsVM.reloadData()
	}
}

extension MainViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let format:CGFloat = collectionView == newsCollectionView ? 1.75 : 1.8
		let width = view.bounds.width - 30
		let height = width / format
		return CGSize(width: width, height: height)
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

		}
		else {

		}
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
