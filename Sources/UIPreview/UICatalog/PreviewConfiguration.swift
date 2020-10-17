#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {
  public struct PreviewConfiguration {
    public init(themes: [Theme] = Theme.allCases,
                contentSize: [UIContentSizeCategory] = [.unspecified]) {
      self.themes = themes
      self.contentSize = contentSize
    }

    let themes: [Theme]
    let contentSize: [UIContentSizeCategory]
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

@available(iOS 14, *)
extension UICatalog.PreviewConfiguration {
  var colorSchemes: [ColorScheme] { themes.map(\.scheme) }
  var contentSizeCategory: [ContentSizeCategory] {
    let categories = contentSize.compactMap { ContentSizeCategory($0) }
    return categories.isEmpty ? [.medium] : categories
  }
}
