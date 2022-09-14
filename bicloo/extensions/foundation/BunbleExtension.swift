//
//  BunbleExtension.swift
//  bicloo
//
//  Created by Cedric Guinoiseau on 02/09/2022.
//

import Foundation

extension Bundle {
    static func getParamString(key: String) -> String {
        return main.infoDictionary![key] as! String
    }
}
