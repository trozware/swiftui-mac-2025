// This sample app accompanies my article on SwiftUI for Mac 2025.
// https://troz.net/post/2025/swiftui-mac-2025/
//
// Sarah Reichelt, July 2025

import SwiftUI
import WebKit

struct WebDemo: View {
  @State private var showLocal = false
  @State private var page = WebPage()

  let myPage = URL(string: "https://troz.net")!
  let blank = URL(string: "about:blank")!

  var body: some View {
    Group {
      if showLocal {
        WebView(page)
      } else {
        WebView(url: myPage)
      }
    }
    .onAppear {
      page.load(html: html, baseURL: blank)
    }
    .toolbar {
      ToolbarItem {
        Picker("Web Source", selection: $showLocal) {
          Label("Remote", systemImage: "phone.connection").tag(false)
          Label("Local", systemImage: "document").tag(true)
        }
        .pickerStyle(.segmented)
      }
    }
  }

  let html = """
    <!DOCTYPE html>
    <html lang=\"en\">
      <head>
        <title>Local HTML</title>
      </head>
      <body>
        <h1>Welcome to the Local Page</h1>
        <h2>This is a demonstration</h2>
        <p>The HTML here is a String property that's loaded into a `WebPage`.</p>
        <ul>
          <li>Item 1</li>
          <li>Item 2</li>
          <li>Item 3</li>
        </ul>
      </body>
    </html>
    """
}

#Preview {
  WebDemo()
}
