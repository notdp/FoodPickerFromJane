//
//  MyUnitProtocol.swift
//  play
//
//  Created by dp on 10/3/24.
//
import Foundation
import SwiftUI

protocol MyUnitProtocol: Codable, Identifiable, CaseIterable, View, Hashable, RawRepresentable where RawValue == String, AllCases: RandomAccessCollection {
    associatedtype T: Dimension

    static var userDefaultsKey: UserDefaults.Key { get }
    static var defaultUnit: Self { get }

    var dimension: T { get }
}

extension MyUnitProtocol {
    static func getPreferredUnit(from store: UserDefaults = .standard) -> Self {
        AppStorage(userDefaultsKey, store: store).wrappedValue
    }
}

extension MyUnitProtocol {
    var id: Self { self }

    var body: some View {
        Text(localizedSymbol)
    }

    var localizedSymbol: String {
        MeasurementFormatter().string(from: dimension)
    }

//    var localizedSymbol: String {
//        let formatter = MeasurementFormatter()
//        formatter.locale = Locale(identifier: "zh_CN")
//        return formatter.string(from: self)
//    }
}

extension Unit {}
