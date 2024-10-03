//
//  SettingScreen.swift
//  play
//
//  Created by dp on 9/23/24.
//

import SwiftUI

struct SettingScreen: View {
    @AppStorage(.shouldUseDarkMode) private var shouldUseDarkMode: Bool = false
    @AppStorage(.preferredWeightUnit) private var unit: MyWeightUnit = .gram
    @AppStorage(.startTab) private var startTab: HomeScreen.Tab = .picker
    @State private var confirmDialog: Dialog = .inactive

    private var shouldShowDialog: Binding<Bool> {
        Binding(
            get: { confirmDialog != .inactive },
            set: { _ in confirmDialog = .inactive }
        )
    }

    var body: some View {
        Form {
            Section("基本设定") {
                Toggle(isOn: $shouldUseDarkMode) {
                    Label("深色模式", systemImage: .moon)
                }
                Picker(selection: $unit) {
                    ForEach(MyWeightUnit.allCases) { $0 }
                } label: {
                    Label("单位", systemImage: .unitSign)
                }
                Picker(selection: $startTab) {
                    Text("随机食物").tag(HomeScreen.Tab.picker)
                    Text("食物清单").tag(HomeScreen.Tab.list)
                } label: {
                    Label("启动页签", systemImage: .house)
                }
            }
            Section("危险区域") {
                ForEach(Dialog.allCases) { dialog in
                    Button(dialog.rawValue) {
                        confirmDialog = dialog
                    }
                }
            }
            .confirmationDialog(confirmDialog.rawValue, isPresented: shouldShowDialog, titleVisibility: .visible) {
                Button("确定", role: .destructive, action: confirmDialog.action)
                Button("取消", role: .cancel) {}
            } message: {
                Text(confirmDialog.message)
            }
        }
    }
}

private enum Dialog: String {
    case resetSettings = "重置设定"
    case resetFoodList = "重置食物清单"
    case inactive

    var message: String {
        switch self {
        case .resetSettings:
            return "重置设定将删除所有自定义食物，并恢复到初始状态。"
        case .resetFoodList:
            return "重置食物清单将删除所有已添加的食物，并恢复到初始状态。"
        case .inactive:
            return ""
        }
    }

    func action() {
        switch self {
        case .resetSettings:
            let keys: [UserDefaults.Key] = [.shouldUseDarkMode, .preferredWeightUnit, .startTab]
            for key in keys {
                UserDefaults.standard.removeObject(forKey: key.rawValue)
            }
        case .resetFoodList:
            UserDefaults.standard.removeObject(forKey: UserDefaults.Key.foodList.rawValue)
        case .inactive:
            return
        }
    }
}

extension Dialog: CaseIterable {
    static let allCases: [Dialog] = [.resetSettings, .resetFoodList]
}

extension Dialog: Identifiable {
    var id: Self { self }
}

#Preview {
    SettingScreen()
}
