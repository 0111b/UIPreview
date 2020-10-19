#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(UIKit)
import UIKit
#endif

extension UICatalog {
  public struct PreviewConfiguration {
    public init(themes: [Theme] = Theme.allCases,
                contentSize: [UIContentSizeCategory] = [.unspecified],
                size: CGSize? = nil) {
      self.themes = themes
      self.contentSize = contentSize
      self.size = size
    }

    let themes: [Theme]
    let contentSize: [UIContentSizeCategory]
    let size: CGSize?

    public func with(size newSize: CGSize) -> PreviewConfiguration {
      PreviewConfiguration(themes: themes, contentSize: contentSize, size: newSize)
    }
  }

  public enum Theme: CaseIterable {
    case light, dark
  }
}

@available(iOS 13, macOS 10.15, *)
extension UICatalog.Theme {
  var scheme: ColorScheme {
    switch self {
    case .light: return .light
    case .dark: return .dark
    }
  }
}

@available(iOS 14, macOS 10.15, *)
extension UICatalog.PreviewConfiguration {
  var colorSchemes: [ColorScheme] { themes.map(\.scheme) }
  var contentSizeCategory: [ContentSizeCategory] {
    let categories = contentSize.compactMap { ContentSizeCategory($0) }
    return categories.isEmpty ? [.medium] : categories
  }
}
