// This sample app accompanies my article on SwiftUI for Mac 2025.
// https://troz.net/post/2025/swiftui-mac-2025/
//
// Sarah Reichelt, July 2025

import SwiftUI

struct ButtonsView: View {
  @State private var toggleIsOn = false

  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 30) {
        Button("Glass") {}
          .buttonStyle(.glass)

        Button("Glass prominent") {}
          .buttonStyle(.glassProminent)
          .tint(toggleIsOn ? .yellow : .accentColor)

        Divider()

        Toggle(isOn: $toggleIsOn) {
          Text("Button toggle")
        }
        .toggleStyle(.button)

        Toggle(isOn: $toggleIsOn) {
          Text("Switch")
        }
        .toggleStyle(.switch)

        Spacer()
      }
    }
    .background(
      toggleIsOn ? Color.yellow.opacity(0.2) : .white
    )
  }
}

#Preview {
  ButtonsView()
}
