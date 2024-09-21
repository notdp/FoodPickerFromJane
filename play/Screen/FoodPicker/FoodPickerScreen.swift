//
//  ContentView.swift
//  play
//
//  Created by dp on 9/2/24.
//

import SwiftUI

struct FoodPickerScreen: View {
    @State private var selectedFood: Food?
    @State private var shouldShowInfo: Bool = false

    let food = Food.example

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                foodImage

                Text("今天吃什么").bold()

                selectedFoodInfoView

                Spacer().layoutPriority(1)

                selectFoodButton

                resetButton
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(.title)
            .mainButtonStyle()
            .animation(.mySpring, value: shouldShowInfo)
            .animation(.myEaseInOut, value: selectedFood)
        }
        .background(.bg2)
    }
}

private extension FoodPickerScreen {
    var foodImage: some View {
        Group {
            if let selectedFood {
                Text(selectedFood.image)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            } else {
                Image("dinner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(height: 250)
    }

    var foodNameView: some View {
        HStack {
            Text(selectedFood!.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.green)
                .id(selectedFood!.name)
                .transition(.delayInsertionOpacity)
            Button {
                shouldShowInfo.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.secondary)
            }.buttonStyle(.plain)
        }
    }

    var foodDetailView: some View {
        VStack {
            if shouldShowInfo {
                Grid(horizontalSpacing: 20, verticalSpacing: 10) {
                    GridRow {
                        Text("蛋白质")
                        Text("脂肪")
                        Text("碳水")
                    }.frame(minWidth: 60)

                    Divider().gridCellUnsizedAxes(.horizontal)
                        .padding(.horizontal, -10)

                    GridRow {
                        Text(selectedFood!.$protein)
                        Text(selectedFood!.$fat)
                        Text(selectedFood!.$carb)
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .padding()
                .roundedRectBackground()
                .minimumScaleFactor(0.7)
                .lineLimit(1)
                .transition(.moveUpWithOpacity)
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }

    @ViewBuilder var selectedFoodInfoView: some View {
        if let selectedFood {
            foodNameView

            Text("热量: \(selectedFood.$calorie)").font(.title2)

            foodDetailView
        }
    }

    var selectFoodButton: some View {
        Button {
            // 随机选择一个食物
            selectedFood = food.randomElement()
        } label: {
            Text(selectedFood == .none ? "点击选择食物" : "换一个").frame(width: 200)
                .animation(.none, value: selectedFood)
                .transformEffect(.identity)
        }
        .padding(.bottom, -15)
    }

    var resetButton: some View {
        Button {
            selectedFood = .none
            shouldShowInfo = false
        } label: {
            Text("重置").frame(width: 200)
        }.buttonStyle(.bordered)
    }

    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

#Preview {
    FoodPickerScreen(selectedFood: .example.first!)
}
