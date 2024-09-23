//
//  HomeScreen.swift
//  play
//
//  Created by dp on 9/22/24.
//
import SwiftUI

extension HomeScreen {
    enum Tab: String, View, CaseIterable {
        case picker, list, settings

        var body: some View {
            content.tabItem { tabLabel.labelStyle(.iconOnly) }
        }

        @ViewBuilder
        private var content: some View {
            switch self {
            case .picker: FoodPickerScreen()
            case .list: FoodListScreen()
            case .settings: SettingScreen()
            }
        }

        private var tabLabel: some View {
            switch self {
            case .picker:
                return Label("Home", systemImage: .house)
            case .list:
                return Label("List", systemImage: .list)
            case .settings:
                return Label("Settings", systemImage: .gear)
            }
        }
    }
}

struct HomeScreen: View {
    @AppStorage(.shouldUseDarkMode) var shouldUseDarkMode = false
    @State var tab: Tab = {
        @AppStorage(.startTab) var startTab: Tab = .picker
        return startTab
    }()

    var body: some View {
        NavigationView {
            TabView(selection: $tab) {
                ForEach(Tab.allCases, id: \.self) {
                    $0
                }
            }
            .preferredColorScheme(shouldUseDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    HomeScreen()
}
