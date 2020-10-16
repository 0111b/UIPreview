#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 13, *)
struct GroupItem: View {
  typealias Element = (title: String, builder: () -> AnyView)

  let items: [Element]

  var body: some View {
    VStack {
      ForEach(items, id: \.title) { item in
        Group {
          Text(item.title)
            .font(.headline)
            .fontWeight(.bold)
          Divider()
          item.builder()
            .frame(maxWidth: .infinity)
        }
      }.padding(.bottom, 10)
    }
  }
}

#if DEBUG
@available(iOS 13, *)
struct GroupItem_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      GroupItem(items: [
        ("Group 1", { AnyView(Text("Preview")) } ),
        ("Group 2", { AnyView(Image(systemName: "square.and.pencil")) } )
      ])
    }
  }
}
#endif
