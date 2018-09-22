//
//  ContactsVC.swift
//  DoubleBurger
//
//  Created by ysoftware on 16.09.2018.
//  Copyright © 2018 Ysoftware. All rights reserved.
//

import UIKit
import MapKit

final class ContactsViewController: UIViewController {

	// MARK: - Outlets
	
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var phoneNumberLabel: UILabel!

	// MARK: - Actions

	@IBAction func vkTapped(_ sender: Any) {
		Presenter.presentApp(in: self,
							 appURLString: "vk://vk.com/2burger",
							 safariURLString: "https://vk.com/2burger")
	}

	@IBAction func igTapped(_ sender: Any) {
		Presenter.presentApp(in: self,
							 appURLString: "instagram://user?username=2burger.ru",
							 safariURLString: "https://www.instagram.com/2burger.ru/")
	}

	@IBAction func fbTapped(_ sender: Any) {
		Presenter.presentApp(in: self,
							 appURLString: "fb://profile/1775995646061900",
							 safariURLString: "https://www.facebook.com/2burger.ru")
	}

	@IBAction func phoneTapped(_ sender: Any) {
		let phoneNumber = "tel://\(placeVM.phoneNumberRaw)"
		UIApplication.shared.open(URL(string: phoneNumber)!, options: [:], completionHandler: nil)

	}

	@IBAction func mailTapped(_ sender: Any) {
		Presenter.presentEmailViewController(in: self)
	}

	@IBAction func mapTapped(_ sender: Any) {

	}

	// MARK: - Properties

	var placeVM:PlaceVM!

	// MARK: - Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	func setup() {
		phoneNumberLabel.text = placeVM.phoneNumber

		mapView.delegate = self
		addPin(for: placeVM)
		focusMapView(placeVM)
	}

	func addPin(for place:PlaceVM) {
		let annotation = MKPointAnnotation()
		let centerCoordinate = place.location.coordinate
		annotation.coordinate = centerCoordinate
		annotation.title = place.address
		mapView.addAnnotation(annotation)
	}

	func focusMapView(_ place:PlaceVM) {
		let mapCenter = place.location.coordinate
		let region = MKCoordinateRegionMakeWithDistance(mapCenter, 200, 200)
		mapView.region = region
	}

	func openMap(at coordinates:CLLocationCoordinate2D, name:String) {
		let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, 200, 200)
		let options = [
			MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
			MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
			MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
			] as [String : Any]
		let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = name
		mapItem.openInMaps(launchOptions: options)
	}
}

extension ContactsViewController: MKMapViewDelegate {

	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		mapView.deselectAnnotation(view.annotation, animated: true)
		openMap(at: placeVM.location.coordinate, name: "2Burger \(placeVM.name)")
	}
}
