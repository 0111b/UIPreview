import SwiftUI

@available(iOS 13, *)
extension View {
  func eraseToAny() -> AnyView {
    AnyView(self)
  }
}
