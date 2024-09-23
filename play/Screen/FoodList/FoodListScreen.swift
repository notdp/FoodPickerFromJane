//
//  FoodListScreen.swift
//  play
//
//  Created by dp on 9/16/24.
//

import SwiftUI

struct FoodListScreen: View {
    @State private var editMode: EditMode = .inactive

    @State private var foods = Food.example

    @State private var selectedFoodIds = Set<Food.ID>()

    var isEditing: Bool { editMode.isEditing }

    @State private var sheet: Sheet?

    var body: some View {
        VStack(alignment: .leading) {
            titleBar // 这里使用 titleBar

            List($foods, editActions: .all, selection: $selectedFoodIds, rowContent: buildFoodRow)
                .listStyle(.plain)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.groupBg2)
                        .ignoresSafeArea()
                }
                .background(.groupBg2)
                .padding(.horizontal)
        }
        .background(.groupBg)
        .safeAreaInset(edge: .bottom, content: buildFlowButton)
        .environment(\.editMode, $editMode)
        .sheet(item: $sheet)
    }

    var titleBar: some View {
        HStack {
            Label("食物清单", systemImage: .forkAndKnife)
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .push(to: .leading)

            EditButton()
                .buttonStyle(.bordered)
                .environment(\.locale, .init(identifier: "zh-Hans"))

            addButton
        }
        .padding()
    }

    var addButton: some View {
        Button {
            sheet = .newFood { foods.append($0) }
        } label: {
            Image(systemName: .plus)
                .font(.system(size: 40))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.accentColor.gradient)
        }
    }

    var removeButton: some View {
        Button {
            withAnimation {
                foods.removeAll { selectedFoodIds.contains($0.id) }
            }
        } label: {
            Text("删除已选项目")
                .font(.title2.bold())
                .maxWidth()
        }
        .mainButtonStyle(shape: .roundedRectangle(radius: 8))
    }

    func buildFlowButton() -> some View {
        ZStack {
            removeButton
                .transition(.move(edge: .leading).combined(with: .opacity).animation(.easeInOut))
                .opacity(isEditing ? 1 : 0)
                .id(isEditing)
        }
    }

    func buildFoodRow(foodBinding: Binding<Food>) -> some View {
        let food = foodBinding.wrappedValue
        return HStack {
            Text(food.name)
                .font(.title3)
                .padding(.vertical, 10)
                .push(to: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    if isEditing {
                        selectedFoodIds.insert(food.id)
                        return
                    }
                    sheet = .foodDetail(food)
                }

            if isEditing {
                Image(systemName: .pencil)
                    .font(.title2.bold())
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        sheet = .editFood(foodBinding)
                    }
            }
        }.listRowBackground(Color.clear)
    }
}

#Preview {
    FoodListScreen()
}
