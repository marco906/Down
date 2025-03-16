//
//  DownViewRepresentable.swift
//  Down
//
//  Created by Marco Wenzel on 15.03.2025.
//

import SwiftUI

#if os(macOS)
struct DownViewWrapper: NSViewRepresentable {
    let markdown: String

    func makeNSView(context: Context) -> DownView {
        do {
            let downView = try DownView(frame: .zero,
                                        markdownString: markdown,
                                        openLinksInBrowser: true,
                                        options: .default
            )
            // Configure the layer for a transparent background.
            downView.wantsLayer = true
            downView.layer?.backgroundColor = NSColor.clear.cgColor
            return downView
        } catch {
            do {
                let fallback = try DownView(frame: .zero,
                                            markdownString: "Error loading markdown.",
                                            openLinksInBrowser: true)
                fallback.wantsLayer = true
                fallback.layer?.backgroundColor = NSColor.clear.cgColor
                return fallback
            } catch {
                fatalError("Unable to create DownView")
            }
        }
    }

    func updateNSView(_ nsView: DownView, context: Context) {
        // For a more dynamic implementation, update the DownView if the markdown changes.
    }
}
#else

#endif

#Preview {
    DownViewWrapper(markdown: """
        # Test H1
        ## Test H2
        ### Test H3
        To reposition the copy button so that it appears above and to the trailing (right) side of your code block, you can make the container absolutely positioned relative to its parent. For example, update your CSS like this:

        ```js
        hljs.addPlugin(new HLJSLanguageDisplayPlugin());
        hljs.highlightAll();
        ```
        Below is an example that integrates the Ink package to convert Markdown to HTML and then displays it in our platform‐agnostic WebView.

        ```swift
        import SwiftUI

        struct MarkdownView: View {
            let markdown: String

            var body: some View {
                // Convert the Markdown to HTML.
                let parser = MarkdownParser()
                let htmlContent = parser.html(from: markdown)
                
                // Display the HTML in our WebView.
                WebView(htmlContent: htmlContent)
                    .edgesIgnoringSafeArea(.all)
            }

            func demo() {
                let maybeNumber: Int? = 10
                let boolValue = true
                let result: NetworkResult<String> = .success("Data loaded")
                switch result {
                case .success(let value):
                    print("Success")
                }
            }
            
            #if os(iOS)
            init(markdown: String) {
                self.markdown = markdown
            }
            #endif
        }
        ```

        ## Explanation

        - **Ink Integration:**
          The `MarkdownView` creates an instance of `MarkdownParser` from Ink and uses it to convert the Markdown string to HTML.

        - **WebView Rendering:**
          The resulting HTML is then passed to the `WebView` (which supports both iOS and macOS) that we configured to have a transparent background and use the system font.

        - **Platform Compatibility:**
          Conditional compilation (`#if os(iOS)` / `#elseif os(macOS)`) ensures the appropriate view representable is used for each platform.

        This setup lets you seamlessly convert Markdown to HTML with Ink and display it in your SwiftUI app on both iOS and macOS.
        """)
    .frame(width: 700, height: 800)
    .background(.black)
}
