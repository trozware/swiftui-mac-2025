// This sample app accompanies my article on SwiftUI for Mac 2025.
// https://troz.net/post/2025/swiftui-mac-2025/
//
// Sarah Reichelt, July 2025

import SwiftUI

@main
struct SwiftUI_Mac_2025App: App {
  @Environment(\.openWindow) var openWindow
  @AppStorage("selectedTab") var selectedTab = 0

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .commands {
      SidebarCommands()
      ToolbarCommands()
      TextEditingCommands()
      TextFormattingCommands()

      CommandMenu("Show") {
        Picker("UI Samples", selection: $selectedTab) {
          Label("Buttons", systemImage: "button.programmable")
            .tag(0)
            .keyboardShortcut("b", modifiers: [.command, .shift])
          Label("Numbers", systemImage: "numbers")
            .tag(1)
            .keyboardShortcut("n", modifiers: [.command, .shift])
          Label("Pickers", systemImage: "circle.grid.2x2.topleft.checkmark.filled")
            .tag(2)
            .keyboardShortcut("p", modifiers: [.command, .shift])
        }
        .pickerStyle(.inline)
        .labelsHidden()

        Divider()

        Button("Web View Demo", systemImage: "network") {
          openWindow(id: "web_demo")
        }
        Button("Text Editing Demo", systemImage: "textformat") {
          openWindow(id: "text_demo")
        }
        Button("List Demo", systemImage: "list.clipboard") {
          openWindow(id: "list_demo")
        }
      }
    }

    Window("Web Demo", id: "web_demo") {
      WebDemo()
    }

    Window("Text Edit Demo", id: "text_demo") {
      TextEditDemo()
    }

    Window("List Demo", id: "list_demo") {
      ListDemo()
    }
  }
}
