import SwiftUI

struct ContentView: View {
  var body: some View {
    Text("Hello, world!")
      .background(Color(.red)).padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewDarkTheme()
  }
}

struct Demo_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      UIViewPreview(UIView())
        .frame(width: 100, height: 30)
        .background(Color(.red))
        .previewLayout(.sizeThatFits)
      UIViewPreview(UILabel(), update: {
        $0.text = "Hello"
        $0.font = UIFont.preferredFont(forTextStyle: .caption1)
        $0.adjustsFontForContentSizeCategory = true
      }).previewAsComponent()
    }
  }
}
