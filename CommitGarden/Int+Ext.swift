//
//  Int+Ext.swift
//  CommitGarden
//
//  Created by hyunho lee on 6/22/23.
//

import Foundation

extension Int {
    func getEmoji() -> String {
        switch self {
        case 1 ..< 4:
            return "🌱"
        case 4 ..< 10:
            return "🌿"
        case 10 ..< 100:
            return "🌳"
        default:
            return "🔥"
        }
    }
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        let prefLanguage = Locale.preferredLanguages[0]

        dateFormatter.locale = NSLocale(localeIdentifier: prefLanguage) as Locale
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
    }
}
