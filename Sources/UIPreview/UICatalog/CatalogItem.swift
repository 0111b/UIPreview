#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 14, macOS 10.15, *)
struct CatalogItem<Content: UICatalogPresentable>: View {
  let configuration: UICatalog.PreviewConfiguration

  var body: some View {
    ForEach(values: Content.previewModels) { model in
      ForEach(values: configuration.colorSchemes) { scheme in
        ForEach(values: configuration.contentSizeCategory) { category in
          item(model: model,
               scheme: scheme,
               category: category,
               size: configuration.size)
        }
      }
    }
  }

  func item(model: Content.PreviewModel,
            scheme: ColorScheme,
            category: ContentSizeCategory,
            size: CGSize?) -> some View {

    VStack(alignment: .center, spacing: 0) {
      HStack {
        Image(systemName: scheme.systemImageName)
        Image(systemName: category.systemImageName)
        Text(String(describing: model))
          .lineLimit(4)
          .frame(maxWidth: 300, alignment: .leading)
      }
      .padding()

      Content.preview(with: model)
        .modifier(SizeModifier(size: size))
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

@available(iOS 13, macOS 10.15, *)
private struct SizeModifier: ViewModifier {
  let size: CGSize?

  func body(content: Content) -> some View {
    guard let size = size else {
      return AnyView(content)
    }
    return AnyView(content.frame(width: size.width,
                                 height: size.height))
  }
}

#if canImport(UIKit)
#if DEBUG
@available(iOS 14, macOS 10.15, *)
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
import UIKit
private final class TestView: UILabel, UICatalogPresentable {
  static var previewModels = [
    "Hello world",
    "Hello2 world",
    "Hello3 world",
    "Hello4 world"
  ]

  func apply(previewModel: String) {
    text = previewModel
    textColor = .systemRed
    numberOfLines = 0
  }
}
#endif
#endif
