#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

@available(iOS 13, *)
public struct UIViewPreview<ContentView: UIView>: UIViewRepresentable {
  let contextBuilder: () -> ViewCoordinator<ContentView>

  public init(_ builder: @autoclosure @escaping () -> ContentView,
       update: @escaping (ContentView) -> Void = { _ in }) {
    contextBuilder = {
      ViewCoordinator(build: builder, update: update)
    }
  }

  public func makeUIView(context: Context) -> ContentView {
    context.coordinator.builder()
  }

  public func updateUIView(_ uiView: ContentView, context: Context) {
    uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    context.coordinator.updater(uiView)
  }

  public func makeCoordinator() -> ViewCoordinator<ContentView> {
    contextBuilder()
  }
}
