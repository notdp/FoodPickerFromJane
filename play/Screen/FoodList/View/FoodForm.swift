//
//  FoodForm.swift
//  play
//
//  Created by dp on 9/17/24.
//

import SwiftUI

private enum myField: Int {
    case title
    case image
    case calorie
    case protein
    case fat
    case carb
}

private extension TextField where Label == Text {
    func focused(_ fieldBinding: FocusState<myField?>.Binding, equals this: myField) -> some View {
        submitLabel(this == .carb ? .done : .next)
            .focused(fieldBinding, equals: this)
            .onSubmit {
                fieldBinding.wrappedValue = .init(rawValue: this.rawValue + 1)
            }
    }
}

extension FoodListScreen {
    struct FoodForm: View {
        @State var food: Food
        @Environment(\.dismiss) var dismiss
        @FocusState private var focusedField: myField?
        var onSubmit: (Food) -> Void

        var body: some View {
            NavigationStack {
                VStack {
                    HStack {
                        Label("编辑食物资讯", systemImage: .pencil)
                            .font(.title.bold())
                            .foregroundColor(.accentColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                        Image(systemName: .xmark)
                            .font(.largeTitle.bold())
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                    .padding([.horizontal, .top])

                    Form {
                        LabeledContent("名称") {
                            TextField("必填", text: $food.name)
                                .focused($focusedField, equals: .title)
                        }
                        LabeledContent("图示") {
                            TextField("图示emoji", text: $food.image)
                                .focused($focusedField, equals: .image)
                        }
                        buildNumberField(title: "热量", value: $food.$calorie, field: .calorie)
                        buildNumberField(title: "蛋白质", value: $food.$protein, field: .protein)
                        buildNumberField(title: "脂肪", value: $food.$fat, field: .fat)
                        buildNumberField(title: "碳水", value: $food.$carb, field: .carb)
                    }

                    Button {
                        dismiss()
                        onSubmit(food)
                    } label: {
                        Text(inValidMessage ?? "保存")
                            .maxWidth()
                    }.mainButtonStyle()
                        .padding()
                        .disabled(isNotValid)
                }
                .background(.groupBg)
                .multilineTextAlignment(.trailing)
                .font(.title3)
                .scrollDismissesKeyboard(.interactively)
                .toolbar(content: buildKeyboardTools)
            }
        }
    }
}

private extension FoodListScreen.FoodForm {
    var inValidMessage: String? {
        if food.name.isEmpty {
            return "名称不能为空"
        }
        if food.image.isEmpty {
            return "图示不能为空"
        }
        if food.image.count != 1 {
            return "图示必须是一个字符"
        }
        return .none
    }

    var isNotValid: Bool {
        food.name.isEmpty || food.image.isEmpty || food.image.count != 1
    }

    func buildNumberField<Unit: MyUnitProtocol>(title: String, value: Binding<Suffix<Unit>>, field: myField) -> some View {
        LabeledContent(title) {
            HStack {
                TextField(title, value: Binding(
                    get: { value.wrappedValue.wrappedValue },
                    set: { value.wrappedValue.wrappedValue = $0 }
                ), format: .number.precision(.fractionLength(1)))
                    .focused($focusedField, equals: field)
                    .keyboardType(.decimalPad)
                if Unit.allCases.count <= 1 {
                    value.unit.wrappedValue.font(.body)
                } else {
                    Picker("单位", selection: value.unit) {
                        ForEach(Unit.allCases)
                    }.labelsHidden()
                }
            }
        }
    }

    func buildKeyboardTools() -> some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button(action: goPreviousField) {
                Image(systemName: .chevronUp)
            }
            Button(action: goNextField) {
                Image(systemName: .chevronDown)
            }
        }
    }

    func goPreviousField() {
        guard let rawValue = focusedField?.rawValue else { return }
        focusedField = .init(rawValue: rawValue - 1)
    }

    func goNextField() {
        guard let rawValue = focusedField?.rawValue else { return }
        focusedField = .init(rawValue: rawValue + 1)
    }
}

#Preview {
    FoodListScreen.FoodForm(food: Food.example.randomElement()!) { _ in }
}
