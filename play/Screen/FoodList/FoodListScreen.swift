//
//  FoodListScreen.swift
//  play
//
//  Created by dp on 9/16/24.
//

import SwiftUI

struct FoodListScreen: View {
    @Environment(\.editMode) var editMode
    
    @State private var foods = Food.example
    
    @State private var selectedFoodIds = Set<Food.ID>()
    
    var isEditing: Bool { editMode?.wrappedValue == .active }
    
    @State private var sheet: Sheet?
    
    var body: some View {
        VStack(alignment: .leading) {
            titleBar // 这里使用 titleBar
            
            List($foods, editActions: .all, selection: $selectedFoodIds, rowContent: buildFoodRow)
                .listStyle(.plain)
                .padding(.horizontal)
        }
        .background(.groupBg)
        .safeAreaInset(edge: .bottom, content: buildFlowButton)
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
        }
        .padding()
    }
    
    var addButton: some View {
        Button {
            sheet = .newFood { foods.append($0) }
        } label: {
            Image(systemName: .plus)
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
            
            
            addButton
                .scaleEffect(isEditing ? 0 : 1)
                .opacity(isEditing ? 0 : 1)
                .animation(.easeInOut, value: isEditing)
                .push(to: .trailing)
                .id(isEditing)
            
        }
    }
    
    func buildFoodRow(foodBinding: Binding<Food>) -> some View {
        let food = foodBinding.wrappedValue
        return HStack {
            Text(food.name).padding(.vertical, 10)
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
        }
    }
    
}

#Preview {
    FoodListScreen()
}
