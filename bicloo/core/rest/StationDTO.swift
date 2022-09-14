//
//  StationDTO.swift
//  bicloo
//
//  Created by Cedric Guinoiseau on 02/09/2022.
//

import Foundation

typealias StationsDTO = [StationDTO]

// MARK: - StationDTO
struct StationDTO: Codable {
    let number: Int
    let contractName, name, address: String
    let position: PositionDTO
    let banking, bonus: Bool
    let status: String
    let lastUpdate: String
    let connected, overflow: Bool
    let totalStands, mainStands: StandsDTO
}

// MARK: - Stands
struct StandsDTO: Codable {
    let availabilities: AvailabilitiesDTO
    let capacity: Int
}

// MARK: - Availabilities
struct AvailabilitiesDTO: Codable {
    let bikes, stands, mechanicalBikes, electricalBikes: Int
    let electricalInternalBatteryBikes, electricalRemovableBatteryBikes: Int
}

// MARK: - Position
struct PositionDTO: Codable {
    let latitude, longitude: Double
}


