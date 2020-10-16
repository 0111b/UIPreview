#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {

  public struct PreviewDescriptor: Identifiable, Hashable {
    let view: AnyView
    public let id: String
    public let title: String
    public var preview: Preview { Preview(view, title: title) }

    public func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    public static func == (lhs: PreviewDescriptor, rhs: PreviewDescriptor) -> Bool {
      lhs.id == rhs.id
    }
  }
  
}

public extension UICatalog.PreviewDescriptor {
  init<Content>(_ content: Content.Type,
                configuration: UICatalog.PreviewConfiguration = .init(),
                title: String? = nil) where Content: UIViewCatalogPresentable {
    id = "\(content)"
    self.title = title ?? "\(content)"
    //    self.view = CatalogPage<Content>(schemes: themes.map(\.scheme))

    self.view = AnyView(Text("sdf"))
  }
}
