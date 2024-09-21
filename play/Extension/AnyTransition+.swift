//
//  AnyTransition.swift
//  play
//
//  Created by dp on 9/22/24.
//
import SwiftUI

extension AnyTransition {
    static let moveUpWithOpacity = move(edge: .top).combined(with: .opacity)

    static let delayInsertionOpacity = Self.asymmetric(
        insertion: .opacity.animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity.animation(.easeInOut(duration: 0.4))
    )
}

