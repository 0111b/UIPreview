#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(UIKit)
import UIKit

@available(iOS 13, macOS 10.15, *)
extension View {
  public func asViewController() -> UIViewController {
    UIHostingController(rootView: self)
  }
}
#endif
