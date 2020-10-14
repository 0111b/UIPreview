import SwiftUI
import UIKit

public struct UIViewControllerPreview<ContentView: UIViewController>: UIViewControllerRepresentable {
  let contextBuilder: () -> ViewCoordinator<ContentView>

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
