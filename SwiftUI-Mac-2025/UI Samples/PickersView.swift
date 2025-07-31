// This sample app accompanies my article on SwiftUI for Mac 2025.
// https://troz.net/post/2025/swiftui-mac-2025/
//
// Sarah Reichelt, July 2025

import SwiftUI

struct PickersView: View {
  let options = ["red", "green", "blue", "yellow"]
  @State private var pickerSelection = "red"

  var body: some View {
    ZStack {
      colorForTint.opacity(0.2)
        .backgroundExtensionEffect()

      VStack(spacing: 30) {
        Picker("Inline:", selection: $pickerSelection) {
          ForEach(options, id: \.self) { color in
            Text(color)
          }
        }
        .pickerStyle(.inline)

        Picker("Menu:", selection: $pickerSelection) {
          ForEach(options, id: \.self) { color in
            Text(color)
          }
        }
        .pickerStyle(.menu)
        .padding()

        Picker("Segmented:", selection: $pickerSelection) {
          ForEach(options, id: \.self) { color in
            Text(color)
          }
        }
        .pickerStyle(.segmented)

        HStack {
          Text("Glass Effect - regular")
            .padding()
            .glassEffect(.regular.tint(colorForTint))

          Text("Glass Effect - clear")
            .padding()
            .glassEffect(.clear.tint(colorForTint))

          Text("Glass Effect - no tint")
            .padding()
            .glassEffect()
        }
      }
      .padding()
    }
  }

  var colorForTint: Color {
    switch pickerSelection {
    case "red":
      return .red
    case "green":
      return .green
    case "blue":
      return .blue
    default:
      return .yellow
    }
  }
}

#Preview {
  PickersView()
    .padding()
}
