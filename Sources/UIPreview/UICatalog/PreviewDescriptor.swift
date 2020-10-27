#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {
  /// Describes the preview that will be generated
  @available(iOS 14, *)
  public struct PreviewDescriptor: Identifiable, Hashable {
    let builder: () -> AnyView
    /// Unique identifier
    public let id: String // swiftlint:disable:this identifier_name
    /// Preview title
    public let title: String
    /// Returns generated preview
    public var preview: Preview { Preview(builder(), title: title) }

    public func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    public static func == (lhs: PreviewDescriptor, rhs: PreviewDescriptor) -> Bool {
      lhs.id == rhs.id
    }
  }

}

@available(iOS 14, *)
public extension UICatalog.PreviewDescriptor {
  /// Creates the instance from suitable `UIView` subtype
  /// - Parameters:
  ///   - content: reference to the type that can be converted to the preview
  ///   - configuration: preview configuration
  ///   - title: preview title
  init<Content>(_ content: Content.Type,
                configuration: UICatalog.PreviewConfiguration = .init(),
                title: String? = nil) where Content: UIViewCatalogPresentable {
    id = "\(content)"
    self.title = title ?? "\(content)"
    builder = { CatalogItem<Content>(configuration: configuration).eraseToAny() }
  }

  /// Group multiple previews together
  /// - Parameters:
  ///   - content: list of the previews
  ///   - title: preview title
  init(_ content: UICatalog.PreviewDescriptor...,
       title: String? = nil) {
    self.init(content, title: title)
  }

  /// Group multiple previews together
  /// - Parameters:
  ///   - content: list of the previews
  ///   - title: preview title
  init(_ content: [UICatalog.PreviewDescriptor],
       title: String? = nil) {
    id = content.map(\.id).joined()
    self.title = title ?? content.map(\.title).joined(separator: " ")
    let items = content.map { GroupItem.Model(title: $0.title, content: $0.builder) }
    builder = { GroupItem(items: items).eraseToAny() }
  }
}
