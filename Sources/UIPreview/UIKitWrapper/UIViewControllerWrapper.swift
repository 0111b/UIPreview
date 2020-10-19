#if canImport(SwiftUI)
import SwiftUI
#endif
import UIKit

/// Generic helper to display `UIViewController` in the Swift UI
@available(iOS 13, *)
public struct UIViewControllerWrapper<ContentView: UIViewController>: UIViewControllerRepresentable {
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

  public func makeUIViewController(context: Context) -> ContentView {
    context.coordinator.builder()
  }

  public func updateUIViewController(_ uiViewController: ContentView, context: Context) {
    context.coordinator.updater(uiViewController)
  }

  public func makeCoordinator() -> ViewCoordinator<ContentView> {
    contextBuilder()
  }
}
