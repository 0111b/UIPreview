#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {
  @available(iOS 13, *)
  public struct PreviewDescriptor: Identifiable, Hashable {
    let builder: () -> AnyView
    public let id: String
    public let title: String
    public var preview: Preview { Preview(builder(), title: title) }

    public func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    public static func == (lhs: PreviewDescriptor, rhs: PreviewDescriptor) -> Bool {
      lhs.id == rhs.id
    }
  }

}

@available(iOS 13, *)
public extension UICatalog.PreviewDescriptor {
  init<Content>(_ content: Content.Type,
                configuration: UICatalog.PreviewConfiguration = .init(),
                title: String? = nil) where Content: UIViewCatalogPresentable {
    id = "\(content)"
    self.title = title ?? "\(content)"
    builder = { AnyView(CatalogItem<Content>(configuration: configuration)) }
  }

  init(_ content: UICatalog.PreviewDescriptor...,
       configuration: UICatalog.PreviewConfiguration = .init(),
       title: String? = nil) {
    self.init(content, configuration: configuration, title: title)
  }

  init(_ content: [UICatalog.PreviewDescriptor],
       configuration: UICatalog.PreviewConfiguration = .init(),
       title: String? = nil) {
    id = content.map(\.id).joined()
    self.title = title ?? content.map(\.title).joined(separator: " ")
    let items = content.map { GroupItem.Model(title: $0.title, content: $0.builder) }
    builder = { AnyView(GroupItem(items: items)) }
  }
}
