// This sample app accompanies my article on SwiftUI for Mac 2025.
// https://troz.net/post/2025/swiftui-mac-2025/
//
// Sarah Reichelt, July 2025

import SwiftUI

struct TextEditDemo: View {
  @State private var text: AttributedString =
    "Enter your text here.\nUse the menu bar, standard shortcuts or right-click menu for formatting."

  var body: some View {
    TextEditor(text: $text)
      .font(.system(size: 14))
      .onAppear(perform: readText)
      .onDisappear(perform: saveText)
  }

  func saveText() {
    if let textData = try? JSONEncoder().encode(text) {
      try? textData.write(to: fileURL)
    }
  }

  func readText() {
    if let data = try? Data(contentsOf: fileURL),
      let loadedText = try? JSONDecoder().decode(
        AttributedString.self,
        from: data
      )
    {
      text = loadedText
    }
  }

  var fileURL: URL {
    URL.documentsDirectory.appendingPathComponent("rich_text.json")
  }
}

#Preview {
  TextEditDemo()
}
