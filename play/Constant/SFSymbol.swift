//
//  SFSymbol.swift
//  play
//
//  Created by dp on 9/22/24.
//
import SwiftUI

enum SFSymbol: String {
    case pencil
    case plus = "plus.circle.fill"
    case chevronUp = "chevron.up"
    case chevronDown = "chevron.down"
    case xmark = "xmark.circle.fill"
    case forkAndKnife = "fork.knife"
    case info = "info.circle.fill"
    case moon = "moon.fill"
    case unitSign = "numbersign"
    case house = "house.fill"
    case list = "list.bullet"
    case gear = "gearshape"
}

extension Label where Title == Text, Icon == Image {
    init(_ title: String, systemImage: SFSymbol) {
        self.init(title, systemImage: systemImage.rawValue)
    }
}

extension Image {
    init(systemName: SFSymbol) {
        self.init(systemName: systemName.rawValue)
    }
}
