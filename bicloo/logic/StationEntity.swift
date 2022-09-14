//
//  StationEntity.swift
//  bicloo
//
//  Created by Cedric Guinoiseau on 02/09/2022.
//

import Foundation

enum StatusEnum: String {
    case OPEN, CLOSED, UNKNOWN
}

struct StationEntity {
    let number: Int
    let name: String
    let longitude: Double
    let latitude: Double
    let state: StatusEnum
    let address: String
    let contractName: String
}

extension StationEntity {
    init(dto: StationDTO) {
        self.init(
            number: dto.number,
            name: dto.name,
            longitude: dto.position.longitude,
            latitude: dto.position.latitude,
            state: StatusEnum(rawValue: dto.status) ?? .UNKNOWN,
            address: dto.address,
            contractName: dto.contractName)
    }
}
