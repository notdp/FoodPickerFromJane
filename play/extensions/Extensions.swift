//
//  Extensions.swift
//  play
//
//  Created by dp on 9/15/24.
//

import SwiftUI

extension View {
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View {
        buttonStyle(.borderedProminent)
            .buttonBorderShape(shape)
            .controlSize(.large)
    }

    func roundedRectBackground(
        radius: CGFloat = 8,
        fill: some ShapeStyle = .bg
    ) -> some View {
        background(
            RoundedRectangle(cornerRadius: radius).fill(fill)
        )
    }
}

extension Animation {
    static let mySpring = Animation.spring(dampingFraction: 0.5)
    static let myEaseInOut = Animation.easeInOut(duration: 0.5)
}

extension ShapeStyle where Self == Color {
    static var bg: Color {
        Color(.systemBackground)
    }

    static var bg2: Color {
        Color(.secondarySystemBackground)
    }

    static var groupBg: Color {
        Color(.systemGroupedBackground)
    }
}

extension AnyTransition {
    static let moveUpWithOpacity = move(edge: .top).combined(with: .opacity)

    static let delayInsertionOpacity = Self.asymmetric(
        insertion: .opacity.animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity.animation(.easeInOut(duration: 0.4))
    )
}

extension AnyLayout {
    static func useVStack(condition: Bool, spacing: CGFloat = 30, @ViewBuilder content: @escaping () -> some View) -> some View {
        let layout = condition ? AnyLayout(VStackLayout(spacing: spacing)) : AnyLayout(HStackLayout(spacing: spacing))
        return layout(content)
    }
}
