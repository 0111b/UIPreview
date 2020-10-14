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

import UIKit

final class TestView: UIView {

  struct Props {
    let title: String
  }

  @IBOutlet private weak var titleLabel: UILabel!

  func render(props: Props) {
    titleLabel.text = props.title
  }
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    UIViewPreview(UILabel(), update: {
      $0.text = "Hello"
      $0.font = UIFont.preferredFont(forTextStyle: .caption1)
      $0.adjustsFontForContentSizeCategory = true
    }).previewAsComponent()
  }
}

