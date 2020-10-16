#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {
  @available(iOS 13, *)
  public struct Preview {
    init(_ view: AnyView, title: String) {
      self.title = title
      self.view = view
    }

    func preview() -> some View {
      ScrollView(.vertical, showsIndicators: true) {
        view
      }.navigationBarTitle(title)
    }

    public func asViewController() -> UIViewController {
      preview().asViewController()
    }

    let title: String
    let view: AnyView
  }
}
