#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

@available(iOS 13, *)
struct CatalogItem<Content: UIViewCatalogPresentable>: View {
  let configuration: UICatalog.PreviewConfiguration

  var body: some View {
    ForEach(values: Content.previewModels) { model in
      ForEach(values: configuration.colorSchemes) { scheme in
        item(model: model, scheme: scheme)
      }
    }
  }

  func item(model: Content.PreviewModel,
            scheme: ColorScheme) -> some View {
    VStack(alignment: .center, spacing: 12.0) {
      Text("\(scheme.previewName):  \(String(describing: model))")
        .font(.subheadline)
        .fontWeight(.bold)
      Content.preview(with: model)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .colorScheme(scheme)
      Divider()
        .background(Color.secondary)
    }
    .padding()
  }
}

#if DEBUG
@available(iOS 13, *)
struct CatalogItem_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScrollView {
        CatalogItem<TestView>(configuration: .init())
      }.navigationBarTitle("TestView")
    }
  }
}

private final class TestView: UILabel, UICatalogPresentable {
  static var previewModels = [
    "Hello world",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
  ]

  func apply(previewModel: String) {
    text = previewModel
  }
}
#endif
