#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

@available(iOS 13, *)
struct CatalogPage<Content: UIViewCatalogPresentable>: View {

  let schemes: [ColorScheme]

  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        ForEach(values: Content.previewModels) { model in
          ForEach(values: schemes) { scheme in
            item(title: "\(scheme):  \(model)") {
              ColorSchemePreview(scheme: scheme) {
                Content.preview(with: model)
              }
            }
          }
        }
      }.navigationBarTitle(String(describing: Content.self))
    }
  }

  func item<Content: View>(title: String,
                           @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    VStack(alignment: .center, spacing: 12.0) {
      Text(title)
        .font(.subheadline)
        .fontWeight(.bold)
      content()
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .padding()
  }
}

//@available(iOS 13, *)
//struct CatalogPage_Previews: PreviewProvider {
//  static var previews: some View {
//    CatalogPage<UISwitch>(schemes: [.light, .dark, ])
//    CatalogPage<UILabel>(schemes: [.light, .dark, ])
//  }
//}
