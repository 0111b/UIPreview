#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

@available(iOS 14, *)
struct CatalogItemView<Content: UICatalogPresentable>: View {
  let configuration: UICatalog.PreviewConfiguration

  var body: some View {
    ForEach(values: Content.previewModels) { model in
      ForEach(values: configuration.colorSchemes) { scheme in
        ForEach(values: configuration.contentSizeCategory) { category in
          configuration.itemStyle
            .body(content: Content.preview(with: model),
                  configuration: .init(modelInfo: String(describing: model),
                                       scheme: scheme,
                                       category: category,
                                       size: configuration.size))
        }
      }
    }
  }
}

#if DEBUG
@available(iOS 14, *)
struct CatalogItem_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScrollView(.vertical) {
        PreviewLegend()
        CatalogItemView<TestView>(configuration: .init())
      }.navigationBarTitle("TestView")
    }
  }
}

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
