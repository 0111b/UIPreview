#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

public enum UICatalog {
  public enum Theme {
    case light, dark
  }

  public static func makePreviewPage<Content>(_ content: Content.Type,
                                              themes: [Theme] = [.light, .dark]
  ) -> UIViewController where Content: UIViewCatalogPresentable {
    guard #available(iOS 13, *) else {
      return UIViewController()
    }
    return CatalogPage<Content>(schemes: themes.map(\.scheme)).asViewController()
  }
}

@available(iOS 13, *)
extension UICatalog.Theme {
  var scheme: ColorScheme {
    switch self {
    case .light: return .light
    case .dark: return .dark
    }
  }
}
