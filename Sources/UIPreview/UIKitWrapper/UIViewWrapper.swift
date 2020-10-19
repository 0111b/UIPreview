#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

/// Generic helper to display `UIView` in the Swift UI
@available(iOS 13, *)
public struct UIViewWrapper<ContentView: UIView>: UIViewRepresentable {
  let contextBuilder: () -> ViewCoordinator<ContentView>

  /// Make new instance with given parameters
  /// - Parameters:
  ///   - builder: describes how to build content
  ///   - update: describes how to update content
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
