//
//  UnitType.swift
//  Optify
//
//  Created by Шоу on 6/21/25.
//

import Foundation

enum UnitType: Int16, CaseIterable, Codable {
    case metric = 0
    case imperial = 1

    static func from(_ raw: Int16) -> UnitType {
        Self(rawValue: raw) ?? .metric
    }

    static var defaultForCurrentLocale: UnitType {
        // Imperial countries: US, Liberia, Myanmar.
        let imperialRegions: Set<String> = ["US", "LR", "MM"]
        if let region = Locale.current.region?.identifier, imperialRegions.contains(region) {
            return .imperial
        }
        return .metric
    }

    var abbreviation: String {
        switch self {
            case .metric: return "m"
            case .imperial: return "ft"
        }
    }

    func convert(distanceInMeters: Double) -> Double {
        let measurement = Measurement(value: distanceInMeters, unit: UnitLength.meters)
        switch self {
            case .metric: return measurement.converted(to: .meters).value
            case .imperial: return measurement.converted(to: .feet).value
        }
    }
}
