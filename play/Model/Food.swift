//
//  Food.swift
//  play
//
//  Created by dp on 9/15/24.
//
import Foundation

struct Food: Equatable, Identifiable {
    var id = UUID()
    var name: String
    var image: String
    @Suffix("千卡") var calorie: Double = .zero
    @Suffix("g") var carb: Double = .zero
    @Suffix("g") var fat: Double = .zero
    @Suffix("g") var protein: Double = .zero

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

    static var new: Food {
        return Food(name: "", image: "")
    }
}
