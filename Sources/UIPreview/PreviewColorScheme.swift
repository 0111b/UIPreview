import SwiftUI

extension View {
  func previewLightTheme() -> some View {
    ColorSchemePreview(scheme: .light) { self }
  }

  func previewDarkTheme() -> some View {
    ColorSchemePreview(scheme: .dark) { self }
  }
}

extension ColorScheme {
  var previewName: String {
    String(describing: self).capitalized
  }
}

struct ColorSchemePreview<Preview: View>: View {
  private let preview: Preview
  private let scheme: ColorScheme

  init(scheme: ColorScheme, @ViewBuilder builder: @escaping () -> Preview) {
    self.scheme = scheme
    preview = builder()
  }

  var body: some View {
    preview
      .previewLayout(.sizeThatFits)
      .background(Color(.systemBackground))
      .colorScheme(scheme)
      .previewDisplayName(scheme.previewName)
  }
}
