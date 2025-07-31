// This sample app accompanies my article on SwiftUI for Mac 2025.
// https://troz.net/post/2025/swiftui-mac-2025/
//
// Sarah Reichelt, July 2025

import SwiftUI

struct ListDemo: View {
  @State private var numberOfItems = 10000
  @State private var listItems: [ListItem] = []
  @State private var selectedItemID: ListItem.ID?
  @State private var statusMessage = "Generating list data…"
  @State private var isGeneratingList = false

  var body: some View {
    NavigationSplitView {
      List(listItems, selection: $selectedItemID) {
        ListRowView(item: $0)
      }
    } detail: {
      if let selectedItemID {
        Text("You have selected row # \(selectedItemID.formatted())")
      } else {
        Text(statusMessage)
      }

      HStack {
        Text("Number of items in list:")
        TextField("Number of items in list:", value: $numberOfItems, formatter: NumberFormatter())
          .frame(width: 100)
          .multilineTextAlignment(.trailing)
      }

      HStack {
        Button("Clear list") {
          selectedItemID = nil
          listItems = []
          statusMessage = "List cleared."
        }
        .disabled(isGeneratingList)

        Button("Generate new list") {
          generateListItems()
        }
        .disabled(isGeneratingList)
      }
    }
    .task {
      generateListItems()
    }
  }

  func generateListItems() {
    Task {
      await MainActor.run {
        selectedItemID = nil
        listItems = []

        isGeneratingList = true
        statusMessage = "Generating list data: \(numberOfItems.formatted())..."
      }

      let newListItems = await ListItem.generateSamples(count: numberOfItems)

      await MainActor.run {
        listItems = newListItems
        statusMessage = "New list data generated."
        isGeneratingList = false
      }
    }
  }
}

#Preview {
  ListDemo()
}

struct ListRowView: View {
  var item: ListItem

  var body: some View {
    HStack {
      Text(item.text)
      Spacer()
      Text(item.symbol)
    }
  }
}

struct ListItem: Identifiable {
  let id: Int
  var text: String
  var symbol: String

  @concurrent
  static func generateSamples(count: Int) async -> [ListItem] {
    let items = (1 ... count).map { index in
      let fizzBuzzSymbol: String
      if index.isMultiple(of: 15) {
        fizzBuzzSymbol = "🍾🐝"
      } else if index.isMultiple(of: 5) {
        fizzBuzzSymbol = "🐝"
      } else if index.isMultiple(of: 3) {
        fizzBuzzSymbol = "🍾"
      } else {
        fizzBuzzSymbol = ""
      }
      return ListItem(
        id: index,
        text: "Row \(index.formatted(.number))",
        symbol: fizzBuzzSymbol
      )
    }
    return items
  }
}
