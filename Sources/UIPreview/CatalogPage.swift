import SwiftUI
import UIKit



public enum UICatalog {
  public enum Theme {
    case light, dark
  }

  public static func makePreviewPage<Content>(_ content: Content.Type,
                                              themes: [Theme] = [.light, .dark]
  ) -> UIViewController where Content: UIViewCatalogPresentable {
    guard #available(iOS 13, *) else {
      return UIViewController()
    }
    return CatalogPage<Content>(schemes: themes.map(\.scheme)).asViewController()
  }
}

func foo() {
  _ = UICatalog.makePreviewPage(UILabel.self)
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

@available(iOS 13, *)
struct CatalogPage<Content: UIViewCatalogPresentable>: View {

  let schemes: [ColorScheme]

  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      ForEach(values: Content.previewModels) { model in
        ForEach(values: schemes) { scheme in
          item(title: "\(Content.self) \(scheme):  \(model)") {
            ColorSchemePreview(scheme: scheme) {
              Content.preview(with: model)
            }
          }
        }
      }
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

@available(iOS 13, *)
struct CatalogPage_Previews: PreviewProvider {
  static var previews: some View {
    CatalogPage<UILabel>(schemes: [.light, .dark, ])
  }
}



//public struct UICatalogPreviewProvider<Content>: PreviewProvider where Content: UIView, Content: UICatalogPresentable {
//
//  static var models: [Content.PreviewModel] { Content.previewModels }
//
//  public static var previews: some View {
//
//    ForEach(values: models) { model in
//      Content.preview(with: model)
//    }
//  }
//}



//
//@available(iOS 13, *)
//struct Test_Previews: PreviewProvider {
//  static var previews: some View {
////    UILabel.preview(with: "Hello").previewAsComponent()
//    UICatalogPreviewProvider<UILabel>.previews
//  }
//}


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
