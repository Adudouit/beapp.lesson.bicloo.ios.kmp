//
//  AFRequestInterceptor.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 13/09/2022.
//

import Foundation
import Alamofire

class AFRequestInterceptor: RequestInterceptor {
	let api_key = Bundle.getParamString(key: "API_KEY")

	func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
		if let urlPath = urlRequest.url?.absoluteString,
		   var components = URLComponents(string: urlPath) {

			var queryItems = components.queryItems ?? []
			queryItems.append(URLQueryItem(name: "apiKey", value: api_key))
			components.queryItems = queryItems

			completion(.success(URLRequest(url: components.url!)))
		}
	}
}
