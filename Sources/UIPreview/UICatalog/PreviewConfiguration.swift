#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UICatalog {
  /// Configuration which will be used for preview generation
  @available(iOS 13, *)
  public struct PreviewConfiguration {
    let themes: [Theme]
    let contentSize: [UIContentSizeCategory]
    let size: CGSize?
    let itemStyle: PreviewItemStyle
  }
}

@available(iOS 13, *)
extension UICatalog.PreviewConfiguration {
  /// Creates new instance
  /// - Parameters:
  ///   - themes: list of themes
  ///   - contentSize: list of content sizes
  ///   - size: required size
  public init(themes: [UICatalog.Theme] = UICatalog.Theme.allCases,
              contentSize: [UIContentSizeCategory] = [.unspecified],
              size: CGSize? = nil) {
    self.themes = themes
    self.contentSize = contentSize
    self.size = size
    itemStyle = UICatalog.DefaultPreviewItemStyle()
  }

  /// Adjusts the size of the generated preview
  /// - Parameter newSize: required size
  /// - Returns: updated configuration
  public func with(size newSize: CGSize) -> UICatalog.PreviewConfiguration {
    UICatalog.PreviewConfiguration(themes: themes, contentSize: contentSize, size: newSize)
  }

  /// Sets the style of a single preview item
  /// - Parameter itemStyle: item style
  /// - Returns: updated configuration
  public func with(itemStyle: PreviewItemStyle) -> UICatalog.PreviewConfiguration {
    UICatalog.PreviewConfiguration(themes: self.themes,
                                   contentSize: self.contentSize,
                                   size: self.size,
                                   itemStyle: self.itemStyle)
  }
}

extension UICatalog {
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
