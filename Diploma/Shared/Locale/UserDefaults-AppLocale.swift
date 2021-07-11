//
//  UserDefaults-AppLocale.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import Foundation

extension UserDefaults {
    private enum Key : String {
        case languageCode = "LanguageCode"
        case regionCode = "RegionCode"
    }

    static var languageCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: Key.languageCode.rawValue)
        }
        set(value) {
            let defs = UserDefaults.standard
            if let value = value {
                defs.set(value, forKey: Key.languageCode.rawValue)
                return
            }
            defs.removeObject(forKey: Key.languageCode.rawValue)
        }
    }

    static var regionCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: Key.regionCode.rawValue)
        }
        set(value) {
            let defs = UserDefaults.standard
            if let value = value {
                defs.set(value, forKey: Key.regionCode.rawValue)
                return
            }
            defs.removeObject(forKey: Key.regionCode.rawValue)
        }
    }
}
