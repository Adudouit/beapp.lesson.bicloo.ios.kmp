//
//  StationsManager.swift
//  bicloo
//
//  Created by Cedric Guinoiseau on 02/09/2022.
//

import Foundation
import Combine

enum StationsError: Error {
    case apiError
}

class StationsManager: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    
    static let shared = StationsManager()
    
    let restManager = RestManager()
    
    @Published var stations = [StationEntity]()
    @Published private(set) var isLoading: Bool = false
    @Published var throwable: StationsError?
    
    @UserDefaultsBacked<String>(key: "selected-city", defaultValue: "nantes") var city
    
    func loadStations() {
        isLoading = true
        restManager.getStationsOfCity(city: city)
            .catch({ [weak self] error -> Just<StationsDTO> in
                self?.throwable = StationsError.apiError
                return Just<StationsDTO>([])
            })
            .map({ [weak self] response -> [StationEntity] in
                self?.isLoading = false
                return response.map({ StationEntity(dto: $0) })
            })
            .assign(to: &$stations)
    }
    
}
