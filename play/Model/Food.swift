//
//  Food.swift
//  play
//
//  Created by dp on 9/15/24.
//
import Foundation
import SwiftUI

struct Food: Equatable, Identifiable {
    var id = UUID()
    var name: String
    var image: String
    @Energy var calorie: Double
    @Weight var carb: Double
    @Weight var fat: Double
    @Weight var protein: Double

    static let example = [
        Food(name: "汉堡", image: "🍔", calorie: 200, carb: 30, fat: 10, protein: 10),
        Food(name: "披萨", image: "🍕", calorie: 300, carb: 40, fat: 15, protein: 15),
        Food(name: "薯条", image: "🍟", calorie: 100, carb: 20, fat: 5, protein: 5),
        Food(name: "可乐", image: "🥤", calorie: 150, carb: 35, fat: 0, protein: 0),
        Food(name: "冰淇淋", image: "🍦", calorie: 250, carb: 45, fat: 12, protein: 8),
        Food(name: "沙拉", image: "🥗", calorie: 80, carb: 10, fat: 3, protein: 5),
        Food(name: "寿司", image: "🍣", calorie: 180, carb: 25, fat: 5, protein: 15),
        Food(name: "苹果", image: "🍎", calorie: 95, carb: 25, fat: 0, protein: 0),
        Food(name: "香蕉", image: "🍌", calorie: 105, carb: 27, fat: 0, protein: 1),
        Food(name: "鸡肉", image: "🍗", calorie: 220, carb: 0, fat: 10, protein: 30),
    ]
}

extension Food {
    static var new: Food {
        let preferredWeightUnit = MyWeightUnit.getPreferredUnit()
        let preferredEnergyUnit = MyEnergyUnit.getPreferredUnit()

        return Food(name: "", image: "",
                    calorie: .init(wrappedValue: .zero, preferredEnergyUnit),
                    carb: .init(wrappedValue: .zero, preferredWeightUnit),
                    fat: .init(wrappedValue: .zero, preferredWeightUnit),
                    protein: .init(wrappedValue: .zero, preferredWeightUnit))
    }

    private init(id: UUID = UUID(), name: String, image: String, calorie: Double, carb: Double, fat: Double, protein: Double) {
        self.id = id
        self.name = name
        self.image = image
        _calorie = .init(wrappedValue: calorie, .cal)
        _carb = .init(wrappedValue: carb, .gram)
        _fat = .init(wrappedValue: fat, .gram)
        _protein = .init(wrappedValue: protein, .gram)
    }
}

extension Food: Codable {}
