#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

public protocol UICatalogPresentable {
  associatedtype PreviewModel: Hashable

  func apply(previewModel: PreviewModel)

  static var previewModels: [PreviewModel] { get }

  static func makePreviewInstance() -> Self

  @available(iOS 13, *)
  func preview(with model: PreviewModel) -> AnyView
}

@available(iOS 13, *)
extension UICatalogPresentable {
  public static func preview(with model: PreviewModel) -> some View {
    makePreviewInstance().preview(with: model)
  }
}

public typealias UIViewCatalogPresentable = UIView & UICatalogPresentable

@available(iOS 13, *)
extension UICatalogPresentable where Self: UIView {
  public func preview(with model: PreviewModel) -> AnyView {
    AnyView(UIViewWrapper(self) { $0.apply(previewModel: model) })
  }
}

extension UICatalogPresentable where Self: UIView {
  public static func makePreviewInstance() -> Self { self.init() }
}
