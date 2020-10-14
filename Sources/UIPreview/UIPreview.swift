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


