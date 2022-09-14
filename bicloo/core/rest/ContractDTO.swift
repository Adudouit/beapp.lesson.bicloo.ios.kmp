//
//  ContractDto.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 13/09/2022.
//

import Foundation

struct ContractDTO: Decodable {
	let cities: [String]?
	let commercial_name: String?
	let country_code: String?
	let name: String

	func toEntity() -> ContractEntity {
		return ContractEntity(cities: cities ?? [], commercialName: commercial_name ?? "", countryCode: country_code ?? "", name: name)
	}
}
