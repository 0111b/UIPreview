#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

@available(iOS 13, *)
extension View {
  public func asViewController() -> UIViewController {
    UIHostingController(rootView: self)
  }
}
