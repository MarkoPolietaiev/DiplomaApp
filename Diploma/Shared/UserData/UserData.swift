//
//  UserData.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import Foundation

class UserData {
    
    enum DefaultsKeys: String {
        case authToken
    }
    
    private static let defaults = UserDefaults.standard
    
}

// MARK: - Private Methods
private extension UserData {
    static func get(_ key: DefaultsKeys) -> Any? {
        return self.defaults.value(forKey: key.rawValue)
    }
    
    static func set(_ value: Any?, key: DefaultsKeys) {
        self.defaults.setValue(value, forKey: key.rawValue)
        self.defaults.synchronize()
    }
}

extension UserData {
    static var authToken: String? {
        get {
            return self.get(.authToken) as? String ?? nil
        }
        set {
            self.set(newValue, key: .authToken)
        }
    }
}
