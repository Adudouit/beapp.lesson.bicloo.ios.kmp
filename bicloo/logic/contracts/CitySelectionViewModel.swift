//
//  CitySelectionViewModel.swift
//  Bicloo
//
//  Created by Anthony Dudouit on136/09/2022.
//

import Foundation
import Combine
import BikeKit

class CitySelectionViewModel: ObservableObject {

	private let restDataSource = RestDataSource()

	private var originalContracts: [ContractEntity] = []

	@Published var contracts: [ContractEntity] = []
	@Published private(set) var isLoading: Bool = false
	@Published var throwable: Error?

	init() {
		fetchContracts()
	}

	func fetchContracts() {

		restDataSource.getContracts { contracts, error in
			DispatchQueue.main.async {

				if let contracts_ = contracts {
					self.contracts = contracts_
				}
				if let error_ = error {
					self.throwable = error_
				}

			}

		}

	}



	func searchForContract(_ search: String) {

		if originalContracts.isEmpty {
			originalContracts = contracts
		}

		if search.isEmpty {
			contracts = originalContracts
			return
		}

		contracts = originalContracts.filter({ contract in
			contract.name.lowercased().contains(search.lowercased())
		})
	}

}
