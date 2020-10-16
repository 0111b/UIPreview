#if canImport(SwiftUI)
import SwiftUI
#endif

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
//        .previewLayout(.sizeThatFits)
        .background(Color(.systemBackground))
        .colorScheme(scheme)
      Divider()

    }
    .padding()
  }
}
