import SwiftUI

final class ViewCoordinator<ContentView: UIView> {
  typealias Builder = () -> ContentView
  typealias Updater = (ContentView) -> Void

  init(build: @escaping Builder, update: @escaping Updater) {
    builder = build
    updater = update
  }

  let builder: Builder
  let updater: Updater
}

struct UIViewPreview<ContentView: UIView>: UIViewRepresentable {
  let contextBuilder: () -> ViewCoordinator<ContentView>

  init(_ builder: @autoclosure @escaping () -> ContentView,
       update: @escaping (ContentView) -> Void = { _ in }) {
    contextBuilder = {
      ViewCoordinator(build: builder, update: update)
    }
  }

  func makeUIView(context: Context) -> ContentView {
    context.coordinator.builder()
  }

  func updateUIView(_ uiView: ContentView, context: Context) {
    uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    context.coordinator.updater(uiView)
  }

  func makeCoordinator() -> ViewCoordinator<ContentView> {
    contextBuilder()
  }
}
