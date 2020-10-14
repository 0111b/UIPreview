import SwiftUI

@available(iOS 13, *)
extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
  init(values: Data, content: @escaping (Data.Element) -> Content) {
    self.init(values, id: \.self, content: content)
  }
}
