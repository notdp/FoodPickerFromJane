//
//  AnyLayout.swift
//  play
//
//  Created by dp on 9/22/24.
//

import SwiftUI

extension AnyLayout {
    static func useVStack(condition: Bool, spacing: CGFloat = 30, @ViewBuilder content: @escaping () -> some View) -> some View {
        let layout = condition ? AnyLayout(VStackLayout(spacing: spacing)) : AnyLayout(HStackLayout(spacing: spacing))
        return layout(content)
    }
}

