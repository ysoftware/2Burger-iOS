//
//  Presenter.swift
//  DoubleBurger
//
//  Created by ysoftware on 16.09.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit
import Presentr
import SafariServices
import MessageUI

final class Presenter {

	private static func presenter(bounds:CGRect, percent:Float) -> Presentr {
		let margin = bounds.height * CGFloat(1 - percent)
		let	top = bounds.height / 2 + margin / 2
		let centerPoint = CGPoint(x: bounds.width / 2,
								  y: top)

		let type = PresentationType.custom(width: .full,
										   height: .fluid(percentage: percent),
										   center: .custom(centerPoint: centerPoint))
		let presenter = Presentr(presentationType: type)
		presenter.blurBackground = false
		presenter.roundCorners = true
		presenter.backgroundColor = .black
		presenter.backgroundOpacity = 0.5
		return presenter
	}

	static func presentCities(in viewController:UIViewController, animated:Bool = true) {
		let vc = R.storyboard.main.cityController()!.inNavigationController
		viewController.present(vc, animated: animated)
	}

	static func presentContacts(in viewController:UIViewController, for placeVM:PlaceVM) {
		let vc = R.storyboard.main.contactsViewController()!
		vc.placeVM = placeVM
		let p = presenter(bounds: viewController.view.bounds, percent: 0.8)
		viewController.customPresentViewController(p, viewController: vc, animated: true)
	}

	static func presentOffer(_ offerVM:OfferVM, in viewController:UIViewController) {
		let vc = R.storyboard.main.codeVC()!
		vc.offerVM = offerVM
		let p = presenter(bounds: viewController.view.bounds, percent: 0.6)
		viewController.customPresentViewController(p, viewController: vc, animated: true)
	}

	static func presentEvent(_ eventVM:EventVM, in viewController:UIViewController) {
		let vc = R.storyboard.main.codeVC()!
		vc.eventVM = eventVM
		let p = presenter(bounds: viewController.view.bounds, percent: 0.7)
		viewController.customPresentViewController(p, viewController: vc, animated: true)
	}

	// MARK: - Url / App

	public static func presentApp(in viewController:UIViewController,
								  appURLString appUrlString:String,
								  safariURLString safariUrlString:String) {
		_presentApp(in: viewController, appURLString: appUrlString, safariURLString: safariUrlString)
	}

	public static func presentApp(in viewController:UIViewController,
								  appURLString appUrlString:String) {
		_presentApp(in: viewController, appURLString: appUrlString, safariURLString: nil)
	}

	public static func presentApp(in viewController:UIViewController,
								  safariURLString safariUrlString:String) {
		_presentApp(in: viewController, appURLString: nil, safariURLString: safariUrlString)
	}

	fileprivate static func _presentApp(in viewController:UIViewController,
										appURLString appUrlString:String?,
										safariURLString safariUrlString:String?) {
		if let appUrlString_ = appUrlString,
			let url = URL(string: appUrlString_),
			UIApplication.shared.canOpenURL(url) {

			UIApplication.shared.open(url, options: [:])
		}
		else if let safariUrlString_ = safariUrlString, let url = URL(string: safariUrlString_) {
			if #available(iOS 9.0, *) {
				viewController.present(SFSafariViewController(url: url), animated: true)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}

	// MARK: - Alerts

	public static func presentAlert(in viewController:UIViewController,
									withTitle title:String,
									message:String) {
		let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
		vc.addAction(.init(title: "Готово", style: .default, handler: nil))
		viewController.present(vc, animated: true)
	}

	// MARK: - Email composer

	public static func presentEmailViewController(
		in viewController:UIViewController,
		mailDelegate:MFMailComposeViewControllerDelegate = mock) {

		guard MFMailComposeViewController.canSendMail() else {
			return Presenter.presentAlert(in: viewController,
										  withTitle: "Не удалось создать письмо",
										  message: "Apple почта не настроена.")
		}

		let bundleVersion = Bundle.main.object(
			forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? "-"
		let appVersion = Bundle.main.object(
			forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "-"

		let vc = MFMailComposeViewController()
		vc.setToRecipients(["anton.larin@2burger.ru"])
		vc.setSubject("Письмо из приложения 2Burger [\(appVersion):\(bundleVersion)]")
		vc.mailComposeDelegate = mailDelegate
		viewController.present(vc, animated: true)
	}
}

// MARK: - Mock delegate for controllers

private let mock = MockDelegate()

private class MockDelegate:NSObject { }

extension MockDelegate: UIPopoverPresentationControllerDelegate { }

extension MockDelegate: UIDocumentInteractionControllerDelegate { }

extension MockDelegate: MFMailComposeViewControllerDelegate {

	func mailComposeController(_ controller: MFMailComposeViewController,
							   didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
}
