import SwiftUI

@available(iOS 13, *)
public protocol PreviewItemStyle {
  /// Creates a view that represents single item of a preview.
  /// - Parameters:
  ///   - content: preview content
  ///   - configuration: the properties of the preview.
  func body(content: AnyView, configuration: Self.Configuration) -> AnyView

  /// The properties of a preview.
  typealias Configuration = UICatalog.PreviewItemStyleConfiguration
}

extension UICatalog {
  @available(iOS 13, *)
  public struct PreviewItemStyleConfiguration {
    public let modelInfo: String
    public let scheme: ColorScheme
    public let category: ContentSizeCategory
    public let size: CGSize?
  }

  @available(iOS 13, *)
  struct DefaultPreviewItemStyle: PreviewItemStyle {
    func body(content: AnyView, configuration: Configuration) -> AnyView {
      UICatalog.DefaultPreviewItemStyleView(content: content,
                                            configuration: configuration)
        .eraseToAny()
    }

  }

  @available(iOS 13, *)
  struct DefaultPreviewItemStyleView: View {
    let content: AnyView
    let configuration: PreviewItemStyleConfiguration

    var body: some View {
      VStack(alignment: .center, spacing: 0) {
        HStack {
          Image(systemName: configuration.scheme.systemImageName)
          Image(systemName: configuration.category.systemImageName)
          Text(configuration.modelInfo)
            .lineLimit(4)
            .frame(maxWidth: 300, alignment: .leading)
        }
        .padding()

        content
          .modifier(SizeModifier(size: configuration.size))
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color(.systemBackground))
          .colorScheme(configuration.scheme)
          .environment(\.sizeCategory, configuration.category)
      }
      .background(Color(.systemGroupedBackground))
      .cornerRadius(6)
      .padding()
    }
  }
}

@available(iOS 13, *)
private struct SizeModifier: ViewModifier {
  let size: CGSize?

  func body(content: Content) -> some View {
    guard let size = size else {
      return content.eraseToAny()
    }
    return content.frame(width: size.width,
                         height: size.height)
      .eraseToAny()
  }
}

#if DEBUG
@available(iOS 13, *)
struct DefaultPreviewItemStyle_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView(.vertical) {
      UICatalog.DefaultPreviewItemStyleView(content: content, configuration: light)
      UICatalog.DefaultPreviewItemStyleView(content: content, configuration: dark)
    }
  }

  static var content: AnyView {
    Text("Hello").background(Color.red)
      .eraseToAny()
  }

  static let light = UICatalog.PreviewItemStyleConfiguration(modelInfo: "Info", scheme: .light,
                                                             category: .medium, size: nil)

  static let dark = UICatalog.PreviewItemStyleConfiguration(modelInfo: "Info", scheme: .dark,
                                                            category: .medium, size: nil)
}
#endif
