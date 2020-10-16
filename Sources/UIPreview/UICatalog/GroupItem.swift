#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 13, *)
struct GroupItem: View {
  struct Model: Identifiable {
    let id = UUID().uuidString
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


@available(iOS 13, *)
struct GroupItemRow: View {

  @State var model: GroupItem.Model

  var body: some View {
    VStack {
      Button(action: {
        model.isExpanded.toggle()
      }, label: {
        HStack {
          Text(model.title)
            .font(.headline)
            .fontWeight(.bold)
          if model.isExpanded {
            Image(systemName: "chevron.up")
          } else {
            Image(systemName: "chevron.down")
          }
        }
        .offset(x: 10)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondary)
        .cornerRadius(8)
      })
      if model.isExpanded {
        model.content()
          .frame(maxWidth: .infinity)
          .padding([.top, .bottom], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
      }
    }
  }
}


#if DEBUG
@available(iOS 13, *)
struct GroupItem_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      GroupItem(items: [
        .init(title: "Group 1",
              content: { AnyView(Text("Preview")) } ),
        .init(title: "Group 2",
              content: { AnyView(Image(systemName: "square.and.pencil")) } )
      ])
    }
  }
}
#endif
