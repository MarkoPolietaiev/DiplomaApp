//
//  Formatters.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-06-26.
//

import Foundation

extension NumberFormatter {

    static let moneyFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.generatesDecimalNumbers = true
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        nf.numberStyle = .decimal
        return nf
    }()

    static func resetupCashed() {
        moneyFormatter.locale = Locale.current
    }
}


extension DateFormatter {

    static let dobFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .full
        return df
    }()

    static func resetupCashed() {
        dobFormatter.locale = Locale.current
    }
}
