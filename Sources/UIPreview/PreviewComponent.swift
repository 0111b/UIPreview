import SwiftUI

extension View {
  public func previewAsComponent() -> some View {
    ComponentPreview(component: self)
  }
}


extension ContentSizeCategory {
  static let smallestAndLargest = [allCases.first!, allCases.last!]

  var previewName: String {
    self == Self.smallestAndLargest.first ? "Small" : "Large"
  }
}

struct ComponentPreview<Component: View>: View {
  var component: Component

  var body: some View {
    ForEach(values: ColorScheme.allCases) { scheme in
      ForEach(values: ContentSizeCategory.smallestAndLargest) { category in
        self.component
          .previewLayout(.sizeThatFits)
          .background(Color(.systemBackground))
          .colorScheme(scheme)
          .environment(\.sizeCategory, category)
          .previewDisplayName(
            "\(scheme.previewName) + \(category.previewName)"
          )
      }
    }
  }
}

