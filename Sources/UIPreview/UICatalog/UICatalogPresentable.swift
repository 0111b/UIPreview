#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

/// Item that can be presented in the UICatalog
public protocol UICatalogPresentable {
  associatedtype PreviewModel: Hashable

  /// Applies data to the instance
  /// - Parameter previewModel: data used in the preview
  func apply(previewModel: PreviewModel)

  /// List of different data configurations used in the preview
  static var previewModels: [PreviewModel] { get }

  /// Generates new instance for the preview
  static func makePreviewInstance() -> Self

  /// Applies preview data 
  /// - Parameter model: preview data
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
