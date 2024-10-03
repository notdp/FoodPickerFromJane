//
//  AppEntry.swift
//  play
//
//  Created by dp on 9/2/24.
//

import SwiftUI

@main
struct AppEntry: App {
    init() {
        applyTabBarBackground()
    }

    var body: some Scene {
        WindowGroup {
            FoodListScreen()
        }
    }
}

extension AppEntry {
    func applyTabBarBackground() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.3)
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
