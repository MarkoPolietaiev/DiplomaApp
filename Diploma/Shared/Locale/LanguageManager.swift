//
//  LanguageManager.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import Foundation
class LanguageManager: NSObject {
    private static let sharedInstance: LanguageManager = {
        let instanse = LanguageManager()
        return instanse
    }()
    
    static func shared() -> LanguageManager {
        return sharedInstance
    }
    
    enum LanguageType: String {
        case russian = "ru"
        case english = "en"
        case polish = "pl"
    }
    
    var currentLanguage: LanguageType {
        get {
            if let languageCode = UserDefaults.languageCode {
                if let type = LanguageType.init(rawValue: languageCode) {
                    return type
                }
            }
            Locale.updateLanguage(code: LanguageType.russian.rawValue)
            return .russian
        }
        set {
            Locale.updateLanguage(code: newValue.rawValue)
        }
    }
    
    func switchLanguage() -> LanguageType {
        if currentLanguage == .russian {
            currentLanguage = .english
        } else {
            currentLanguage = .russian
        }
        return currentLanguage
    }
}
