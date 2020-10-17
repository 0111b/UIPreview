#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

// TODO: remove UIView dependency

@available(iOS 14, *)
struct CatalogItem<Content: UIViewCatalogPresentable>: View {
  let configuration: UICatalog.PreviewConfiguration

  var body: some View {
    ForEach(values: Content.previewModels) { model in
      ForEach(values: configuration.colorSchemes) { scheme in
        ForEach(values: configuration.contentSizeCategory) { category in
          item(model: model, scheme: scheme, category: category)
        }
      }
    }
  }

  func item(model: Content.PreviewModel,
            scheme: ColorScheme,
            category: ContentSizeCategory) -> some View {


    VStack(alignment: .center, spacing: 0) {
      HStack {
        Image(systemName: scheme.systemImageName)
        Image(systemName: category.systemImageName)
        Text(String(describing: model))
      }
      .padding()

      Content.preview(with: model)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .colorScheme(scheme)
        .environment(\.sizeCategory, category)
    }
    .background(Color(.systemGroupedBackground))
    .cornerRadius(6)
    .padding()
  }
}

#if DEBUG
@available(iOS 14, *)
struct CatalogItem_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScrollView(.vertical) {
        PreviewLegend()
        CatalogItem<TestView>(configuration: .init())
      }.navigationBarTitle("TestView")
    }
  }
}

private final class TestView: UILabel, UICatalogPresentable {
  static var previewModels = [
    "Hello world",
//    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
    "Hello2 world",
    "Hello3 world",
    "Hello4 world",
  ]

  func apply(previewModel: String) {
    text = previewModel
    textColor = .systemRed
    numberOfLines = 0
  }
}
#endif
