//
//  RestManager.swift
//  bicloo
//
//  Created by Cedric Guinoiseau on 02/09/2022.
//

import Foundation
import Alamofire
import Combine

class RestManager {
    
    var api_url = Bundle.getParamString(key: "API_URL")
    let requestInterceptor = AFRequestInterceptor()

    func getStationsOfCity(city: String) -> AnyPublisher<StationsDTO, AFError> {
        let params =  ["contract": city]
		return get(path: "stations", query: params)
    }

	func fetchContracts() -> AnyPublisher<[ContractDTO], AFError>  {
		return get(path: "contracts")
	}
    
	func get<T: Decodable>(path: String, query: [String: String]? = nil) -> AnyPublisher<T, AFError> {

		let url = self.createURL(path: path, query: query)

		return AF.request(url, method: .get, interceptor: requestInterceptor)
			.validate()
			.publishDecodable(type: T.self)
			.value()
	}

	private func createURL(path: String, query: [String: String]? = nil) -> URL {

		var url = URL(string: api_url)!.appendingPathComponent(path)

		if let query = query {

			var components = URLComponents(string: url.absoluteString)!

			let queries = query.map { (key, value) in
				URLQueryItem(name: key, value: value)
			}
			var queryItems = components.queryItems ?? []

			queryItems.append(contentsOf: queries)
			components.queryItems = queryItems

			url = components.url!

		}

		return url

	}
}
