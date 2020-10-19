#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {
  ///  Generated preview instance
  @available(iOS 14, *)
  public struct Preview {
    init(_ view: AnyView, title: String) {
      self.title = title
      self.view = view
    }

    func preview() -> some View {
      ScrollView(.vertical, showsIndicators: true) {
        PreviewLegend()
        view
      }.navigationBarTitle(title)
    }

    /// Convert preview to the `UIViewController`
    /// - Returns: generated UIViewController instance
    public func asViewController() -> UIViewController {
      preview().asViewController()
    }

    let title: String
    let view: AnyView
  }
}
