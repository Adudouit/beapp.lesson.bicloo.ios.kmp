//
//  UserDefault.swift
//  bicloo
//
//  Created by Cedric Guinoiseau on 02/09/2022.
//

import Foundation

@propertyWrapper struct UserDefaultsBacked<Value> {
    let key: String
    let defaultValue: Value
    var storage: UserDefaults = .standard

    var wrappedValue: Value {
        get { storage.value(forKey: key) as? Value ?? defaultValue }
        set { storage.setValue(newValue, forKey: key) }
    }
}
