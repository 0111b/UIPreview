#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

extension UISwitch: UICatalogPresentable {
  public static var previewModels = [true, false]

  public func apply(previewModel: Bool) {
    isOn = previewModel
  }
}

extension UILabel: UICatalogPresentable {
  public static var previewModels: [String] {
    ["123", "345", "Hello world", "How do you do"]
  }

  public func apply(previewModel: String) {
    text = previewModel
  }

  public static func makePreviewInstance() -> Self {
    let label = UILabel()
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    return label as! Self
  }
}

