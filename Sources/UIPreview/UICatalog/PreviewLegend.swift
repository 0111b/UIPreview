#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 14, macOS 10.15, *)
struct PreviewLegend: View {
  @State var isExpanded: Bool = false

  var body: some View {
    VStack(alignment: .leading) {
      Button(action: {
        isExpanded.toggle()
      }, label: {
        Label("Legend",
              systemImage: isExpanded
                ? "chevron.up"
                : "chevron.down")
          .foregroundColor(.primary)
      })
      if isExpanded {
        PreviewLegendBody()
      }
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color(.systemGroupedBackground))
    .cornerRadius(6)
    .padding()
  }
}

@available(iOS 14, macOS 10.15, *)
private struct PreviewLegendBody: View {
  var body: some View {
    VStack(alignment: .leading) {
      Divider()
        .foregroundColor(.accentColor)
      Text("Theme: ")
        .font(.headline)
        .padding()
      ForEach(values: UICatalog.Theme.allCases) { theme in
        Label {
          Text(theme.legend)
        } icon: {
          Image(systemName: theme.scheme.systemImageName)
        }
      }
      Text("Content size: ")
        .font(.headline)
        .padding()
      ForEach(values: ContentSizeCategory.allCases) { category in
        Label {
          Text(String(describing: category))
        } icon: {
          Image(systemName: category.systemImageName)
        }
      }
    }
  }
}

@available(iOS 14, macOS 10.15, *)
struct PreviewLegend_Previews: PreviewProvider {
  static var previews: some View {
    PreviewLegend()
      .previewLayout(.sizeThatFits)
  }
}

private extension UICatalog.Theme {
  var legend: String {
    switch self {
    case .light: return "Light theme"
    case .dark: return "Dark theme"
    }
  }
}

@available(iOS 13, macOS 10.15, *)
extension ContentSizeCategory {
  var systemImageName: String {
    switch self {
    case .accessibilityExtraExtraExtraLarge: return "7.circle.fill"
    case .accessibilityExtraExtraLarge: return "4.circle.fill"
    case .extraSmall: return "1.circle"
    case .small: return "2.circle"
    case .medium: return "3.circle"
    case .large: return "4.circle"
    case .extraLarge: return "5.circle"
    case .extraExtraLarge: return "6.circle"
    case .extraExtraExtraLarge: return "7.circle"
    case .accessibilityMedium: return "3.circle.fill"
    case .accessibilityLarge: return "4.circle.fill"
    case .accessibilityExtraLarge: return "5.circle.fill"
    @unknown default:
      return "questionmark"
    }
  }
}
