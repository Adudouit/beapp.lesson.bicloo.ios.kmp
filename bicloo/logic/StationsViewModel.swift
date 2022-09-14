//
//  StationsViewModel.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 13/09/2022.
//

import Foundation
import Combine
import BikeKit

class StationsViewModel: ObservableObject {

	private let restDataSource = RestDataSource()

	@Published var selectedStation: [StationEntity] = []
	@Published var stations: [StationEntity] = []
	@Published private(set) var isLoading: Bool = false
	@Published var throwable: Error?

	public static let shared = StationsViewModel()

	private init() {}

	func fetchStations(contract: ContractEntity) {
		isLoading = true

		restDataSource.getStationsOfCity(city: contract.name) { stations, error in
			DispatchQueue.main.async {

				if let stations_ = stations {
					self.stations = stations_
				}
				if let error_ = error {
					self.throwable = error_
				}

			}

		}

	}

	func select(station: StationEntity) {
		self.selectedStation = [station]
	}

	func reset() {
		self.selectedStation = self.stations
	}

}
