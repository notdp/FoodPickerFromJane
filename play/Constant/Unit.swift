//
//  Unit.swift
//  play
//
//  Created by dp on 9/23/24.
//

import SwiftUI

enum Unit: String, CaseIterable, Identifiable, View {
    case gram = "g", pound = "lb"

    var id: Self { self }

    var body: some View {
        Text(rawValue)
    }
}
