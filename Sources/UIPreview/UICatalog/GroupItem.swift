#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 14, macOS 10.15, *)
struct GroupItem: View {
  struct Model: Identifiable {
    let id = UUID().uuidString // swiftlint:disable:this identifier_name
    var isExpanded = false
    let title: String
    let content: () -> AnyView
  }

  let items: [Model]

  var body: some View {
    ForEach(items) { item in
      GroupItemRow(model: item).buttonStyle(PlainButtonStyle())
    }
  }
}

@available(iOS 14, macOS 10.15, *)
struct GroupItemRow: View {

  @State var model: GroupItem.Model

  var body: some View {
    VStack {
      Button(action: {
        model.isExpanded.toggle()
      }, label: {
        Label(model.title,
              systemImage: model.isExpanded
                ? "chevron.up"
                : "chevron.down")
      })
      .frame(maxWidth: .infinity)
      .padding()
      .background(Color(.systemGroupedBackground))
      .cornerRadius(6)
      .padding()

    }
    if model.isExpanded {
      model.content()
        .frame(maxWidth: .infinity)
        .padding([.top, .bottom], 10)
    }
  }
}

#if DEBUG
@available(iOS 14, macOS 10.15, *)
struct GroupItem_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      PreviewLegend()
      GroupItem(items: [
        .init(title: "Group 1",
              content: { AnyView(Text("Preview")) }),
        .init(title: "Group 2",
              content: { AnyView(Image(systemName: "square.and.pencil")) })
      ])
    }
  }
}
#endif
