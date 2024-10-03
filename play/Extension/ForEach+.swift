//
//  ForEach+.swift
//  play
//
//  Created by dp on 10/2/24.
//

import SwiftUI

extension ForEach where Data.Element: Identifiable & View, ID == Content.ID, Content == Data.Element {
    init(_ data: Data) {
        self.init(data) { $0 }
    }
}
