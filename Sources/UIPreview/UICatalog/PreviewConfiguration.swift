#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {
  /// Configuration which will be used for preview generation
  public struct PreviewConfiguration {
    /// Creates new instance
    /// - Parameters:
    ///   - themes: list of themes
    ///   - contentSize: list of content sizes
    ///   - size: required size
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

    /// Adjusts the size of the generated preview
    /// - Parameter newSize: required size
    /// - Returns: updated configuration
    public func with(size newSize: CGSize) -> PreviewConfiguration {
      PreviewConfiguration(themes: themes, contentSize: contentSize, size: newSize)
    }
  }

  /// Represents color scheme
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
