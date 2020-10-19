#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 13, macOS 10.15, *)
extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
  init(values: Data, content: @escaping (Data.Element) -> Content) {
    self.init(values, id: \.self, content: content)
  }
}
