//
//  UserData.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import Foundation

class UserData {
    
    enum DefaultsKeys: String {
        case firstLaunch
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
    
    // First launch is true by default and changes to false whenever user creates and account or logs in so we do not need to show greetings vc.
    static var firstLaunch: Bool {
        get {
            return self.get(.firstLaunch) as? Bool ?? true
        }
        set {
            self.set(newValue, key: .firstLaunch)
        }
    }
    
    static var authToken: String? {
        get {
            return self.get(.authToken) as? String ?? nil
        }
        set {
            self.set(newValue, key: .authToken)
        }
    }
}
