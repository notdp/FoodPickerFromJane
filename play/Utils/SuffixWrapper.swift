//
//  SuffixWrapper.swift
//  play
//
//  Created by dp on 9/15/24.
//

@propertyWrapper struct Suffix: Equatable {
    var wrappedValue: Double
    private let suffix: String

    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }

    var projectedValue: String {
        return wrappedValue.formatted() + suffix
    }
}
