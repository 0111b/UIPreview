#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {
  public struct PreviewConfiguration {
    public init(themes: [Theme] = Theme.allCases) {
      self.themes = themes
    }

    let themes: [Theme]
  }

  public enum Theme: CaseIterable {
    case light, dark
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
