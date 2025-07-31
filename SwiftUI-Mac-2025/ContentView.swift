// This sample app accompanies my article on SwiftUI for Mac 2025.
// https://troz.net/post/2025/swiftui-mac-2025/
//
// Sarah Reichelt, July 2025

import SwiftUI

struct ContentView: View {
  @Environment(\.openWindow) var openWindow
  @AppStorage("selectedTab") var selectedTab = 0

  var body: some View {
    TabView(selection: $selectedTab) {
      Tab("Buttons", systemImage: "button.programmable", value: 0) {
        ButtonsView()
      }

      Tab("Numbers", systemImage: "numbers", value: 1) {
        NumbersView()
      }

      Tab("Pickers", systemImage: "circle.grid.2x2.topleft.checkmark.filled", value: 2) {
        PickersView()
      }
    }
    .tabViewStyle(.sidebarAdaptable)
    .navigationSubtitle("Optional window subtitle")
    .frame(minWidth: 500, minHeight: 100)
    .toolbar {
      ToolbarSpacer(.flexible)

      ToolbarItemGroup {
        Button {
          openWindow(id: "web_demo")
        } label: {
          Label("Web", systemImage: "network")
        }

        Button {
          openWindow(id: "text_demo")
        } label: {
          Label("Text", systemImage: "textformat")
        }
      }

      ToolbarSpacer(.fixed)

      ToolbarItem {
        Button {
          openWindow(id: "list_demo")
        } label: {
          Label("List Demo", systemImage: "list.clipboard")
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
