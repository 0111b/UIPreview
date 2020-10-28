#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 14, *)
struct GroupItemView<Content>: View where Content: View {
  struct Model {
    let title: String
    let content: () -> Content
  }

  let items: [Model]

  var body: some View {
    ForEach(items, id: \.title) { item in
      ExpandGroup(item.title) {
        item.content()
      }
    }
  }
}

#if DEBUG
@available(iOS 14, *)
struct GroupItem_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      PreviewLegend()
      GroupItemView(items: [
        .init(title: "Group 1",
              content: { AnyView(Text("Preview")) }),
        .init(title: "Group 2",
              content: { AnyView(Image(systemName: "square.and.pencil")) })
      ])
    }
  }
}
#endif
