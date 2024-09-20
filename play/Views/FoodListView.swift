//
//  FoodListView.swift
//  play
//
//  Created by dp on 9/16/24.
//

import SwiftUI

private enum Sheet:View,Identifiable{
    case newFood((Food) -> Void)
    case editFood(Binding<Food>)
    case foodDetail(Food)
    
    var id:UUID {
        switch self {
        case .newFood(_) :
            return UUID()
        case .editFood(let binding):
            return binding.wrappedValue.id
        case .foodDetail(let food):
            return food.id
        }
    }
    
    var body:some View {
        switch self {
        case .newFood(let onSubmit):
            FoodListView.FoodForm(food:.new,onSubmit:onSubmit)
        case .editFood(let binding):
            FoodListView.FoodForm(food:binding.wrappedValue) { binding.wrappedValue = $0}
        case .foodDetail(let food):
            FoodListView.FoodDetailSheet(food:food)
        }
    }
}

struct FoodListView: View {
    @Environment(\.editMode) var editMode
    
    @State private var foods = Food.example
    
    @State private var selectedFoodIds = Set<Food.ID>()
    
    var isEditing: Bool { editMode?.wrappedValue == .active }
    
    
    @State private var sheet:Sheet?
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar // 这里使用 titleBar
            
            List($foods, editActions: .all, selection: $selectedFoodIds,rowContent: buildFoodRow)
                .listStyle(.plain)
                .padding(.horizontal)
        }
        .background(.groupBg)
        .safeAreaInset(edge: .bottom, content: buildFlowButton)
        .sheet(item: $sheet) { $0 }
        
        
    }
    
    
}

extension FoodListView {
    struct FoodDetailSheetHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 10
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    struct FoodDetailSheet: View {
        @Environment(\.dynamicTypeSize) private var textSize
        @State private var sheetHeight: CGFloat = FoodDetailSheetHeightKey.defaultValue
        
        let food:Food
        
        var body: some View {
            let shouldVStack = textSize.isAccessibilitySize || food.image.count > 1
            AnyLayout.useVStack(condition: shouldVStack, spacing: 30) {
                Text(food.image).font(.system(size: 100))
                Grid(horizontalSpacing: 20, verticalSpacing: 10) {
                    buildNutritionView(title: "热量", value: food.$calorie)
                    buildNutritionView(title: "蛋白质", value: food.$protein)
                    buildNutritionView(title: "脂肪", value: food.$fat)
                    buildNutritionView(title: "碳水", value: food.$carb)
                }
            }
            .padding()
            .padding(.vertical)
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: FoodDetailSheetHeightKey.self, value: proxy.size.height)
                }
            }
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
    
    var titleBar: some View {
        HStack {
            Label("食物清单", systemImage: "fork.knife")
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            EditButton()
                .buttonStyle(.bordered)
                .environment(\.locale, .init(identifier: "zh-Hans"))
        }
        .padding()
    }
    
    var addButton: some View {
        Button {
            sheet = .newFood { foods.append($0)}
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .padding()
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
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .mainButtonStyle(shape: .roundedRectangle(radius: 8))
    }
    
    func buildFlowButton() -> some View {
        ZStack {
            removeButton
                .transition(.move(edge: .leading).combined(with: .opacity).animation(.easeInOut))
                .opacity(isEditing ? 1 : 0)
                .id(isEditing)
            HStack {
                Spacer()
                addButton
                    .scaleEffect(isEditing ? 0 : 1)
                    .opacity(isEditing ? 0 : 1)
                    .animation(.easeInOut, value: isEditing)
                    .id(isEditing)
            }
        }
    }
    
    func buildFoodRow(foodBinding:Binding<Food>) -> some View {
        let food = foodBinding.wrappedValue
        return HStack {
            Text(food.name).padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    if isEditing {
                        selectedFoodIds.insert(food.id)
                        return }
                    sheet = .foodDetail(food)
                }
            
            if isEditing {
                Image(systemName: "pencil")
                    .font(.title2.bold())
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        sheet = .editFood(foodBinding)
                    }
            }
        }
    }
}

#Preview {
    FoodListView()
}
