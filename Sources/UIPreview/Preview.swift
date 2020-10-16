#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {
  public struct Preview {
    init(_ view: AnyView, title: String) {
      self.title = title
      self.view = view
    }

    public func asViewController() -> UIViewController {
      ScrollView(.vertical, showsIndicators: true) {
        view
      }.navigationBarTitle(title)
      .asViewController()
    }

    let title: String
    let view: AnyView
  }
}
