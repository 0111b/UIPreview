public final class ViewCoordinator<ContentView> {
  typealias Builder = () -> ContentView
  typealias Updater = (ContentView) -> Void

  init(build: @escaping Builder, update: @escaping Updater) {
    builder = build
    updater = update
  }

  let builder: Builder
  let updater: Updater
}
