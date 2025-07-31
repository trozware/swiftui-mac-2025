// This sample app accompanies my article on SwiftUI for Mac 2025.
// https://troz.net/post/2025/swiftui-mac-2025/
//
// Sarah Reichelt, July 2025

import SwiftUI

struct NumbersView: View {
  @State private var sliderValue = 5.0
  @State private var stepperValue = 0.5
  @State private var isEditingSlider = false

  var body: some View {
    VStack(spacing: 30) {
      Slider(
        value: $sliderValue,
        in: 0 ... 10,
        step: 1
      ) {
        Text("Speed")
      } minimumValueLabel: {
        Image(systemName: "tortoise")
      } maximumValueLabel: {
        Image(systemName: "hare")
      } onEditingChanged: { isEditing in
        isEditingSlider = isEditing
      }
      .labelsHidden()
      .padding(.horizontal)

      Text("Speed: \(Int(sliderValue))")
        .foregroundStyle(isEditingSlider ? Color.accentColor : .primary)

      Divider()

      Stepper(
        value: $stepperValue,
        in: 0 ... 1,
        step: 0.05,
        format: .percent
      ) {
        Text("Percentage:")
      }
      .multilineTextAlignment(.trailing)
    }
  }
}

#Preview {
  NumbersView()
}

/*
      \(isEditingSlider ? "Dragging..." : "")
 */
