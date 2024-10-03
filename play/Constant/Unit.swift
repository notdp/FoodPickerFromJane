//
//  Unit.swift
//  play
//
//  Created by dp on 9/23/24.
//

import Foundation

enum MyEnergyUnit: String, MyUnitProtocol {
    static var userDefaultsKey: UserDefaults.Key = .preferredEnergyUnit
    static var defaultUnit: MyEnergyUnit = .cal
    case cal = "大卡"
    var dimension: UnitEnergy { .calories }
}

enum MyWeightUnit: String, MyUnitProtocol {
    static var userDefaultsKey: UserDefaults.Key = .preferredWeightUnit
    static var defaultUnit: MyWeightUnit = .gram
    case gram = "g", pound = "lb", ounce
    var dimension: UnitMass {
        switch self {
        case .gram: return .grams
        case .pound: return .pounds
        case .ounce: return .ounces
        }
    }
}
