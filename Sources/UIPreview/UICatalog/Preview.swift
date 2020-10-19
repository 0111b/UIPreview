#if canImport(SwiftUI)
import SwiftUI
#endif

extension UICatalog {
  @available(iOS 14, macOS 10.15, *)
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

    let title: String
    let view: AnyView
  }
}

#if canImport(UIKit)
import UIKit
@available(iOS 14, macOS 10.15, *)
extension UICatalog.Preview {
  public func asViewController() -> UIViewController {
    preview().asViewController()
  }

}
#endif
