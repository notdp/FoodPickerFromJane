//
//  FoodDetailSheet.swift
//  play
//
//  Created by dp on 9/21/24.
//
import SwiftUI

extension FoodListScreen {
    private struct FoodDetailSheetHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 300
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }

    struct FoodDetailSheet: View {
        @Environment(\.dynamicTypeSize) private var textSize
        @State private var sheetHeight: CGFloat = FoodDetailSheetHeightKey.defaultValue

        let food: Food

        var body: some View {
            let shouldVStack = textSize.isAccessibilitySize || food.image.count > 1
            AnyLayout.useVStack(condition: shouldVStack, spacing: 30) {
                Text(food.image).font(.system(size: 100))
                Grid(horizontalSpacing: 20, verticalSpacing: 10) {
                    buildNutritionView(title: "热量", value: food.$calorie.description)
                    buildNutritionView(title: "蛋白质", value: food.$protein.description)
                    buildNutritionView(title: "脂肪", value: food.$fat.description)
                    buildNutritionView(title: "碳水", value: food.$carb.description)
                }
            }
            .padding()
            .padding(.vertical)
            .maxWidth()
            .background(.groupBg2)
            .readGeometry(key: FoodDetailSheetHeightKey.self, keyPath: \.size.height)
            .onPreferenceChange(FoodDetailSheetHeightKey.self) {
                sheetHeight = $0
            }
            .presentationDetents([.height(sheetHeight)])
        }

        func buildNutritionView(title: String, value: String) -> some View {
            GridRow {
                Text(title).gridCellAnchor(.leading)
                Text(value).gridCellAnchor(.trailing)
            }
        }
    }
}
