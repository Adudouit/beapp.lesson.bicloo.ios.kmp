//
//  MapViewController.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 13/09/2022.
//

import UIKit
import MapKit
import Combine
import CoreLocation

class MapViewController: UIViewController {

	private let viewModel = StationsViewModel.shared
	private var cancellables: Set<AnyCancellable> = []

	@IBOutlet weak var mapView: MKMapView!

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		viewModel.$selectedStation
			.sink { [weak self] stations_ in
				let annotations: [MKPointAnnotation] = stations_.map { station in
					let point = MKPointAnnotation()
					point.title = station.name
					point.subtitle = station.address
					point.coordinate = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
					return point
				}
				if let mapView = self?.mapView {
					mapView.addAnnotations(annotations)
					mapView.showAnnotations(mapView.annotations, animated: true)
				}

			}
			.store(in: &cancellables)

	}

    override func viewDidLoad() {
        super.viewDidLoad()

		self.manageUserLocation()
		mapView.showsCompass = true
		mapView.showsUserLocation = true
    }

	func manageUserLocation() {
		let locationManager = CLLocationManager()
		locationManager.requestWhenInUseAuthorization()
	}
}
