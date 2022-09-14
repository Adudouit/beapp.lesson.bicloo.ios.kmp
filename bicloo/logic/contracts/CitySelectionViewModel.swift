//
//  CitySelectionViewModel.swift
//  Bicloo
//
//  Created by Anthony Dudouit on136/09/2022.
//

import Foundation
import Combine

class CitySelectionViewModel: ObservableObject {

	private let restManager = RestManager()

	private var originalContracts: [ContractEntity] = []

	@Published var contracts: [ContractEntity] = []
	@Published private(set) var isLoading: Bool = false
	@Published var throwable: StationsError?

	init() {
		fetchContracts()
	}

	func fetchContracts() {

		restManager.fetchContracts()
			.catch({ [weak self] error -> Just<[ContractDTO]> in
				self?.throwable = StationsError.apiError
				return Just<[ContractDTO]>([])
			})
				.map({ [weak self] response -> [ContractEntity] in
					self?.isLoading = false
					return response.map { $0.toEntity() }
				})
					.assign(to: &$contracts)

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
