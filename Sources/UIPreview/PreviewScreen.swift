import SwiftUI

public let defaultDeviceNames: [String] =
  [
    "iPhone 8",
    "iPhone 11",
    "iPhone 11 Pro Max",
    "iPad (7th generation)",
    "iPad Pro (12.9-inch) (4th generation)"
  ]

extension View {
  public func previewAsScreen(deviceNames: [String] = defaultDeviceNames) -> some View {
    ScreenPreview(screen: self, deviceNames: deviceNames)
  }
}

struct ScreenPreview<Screen: View>: View {
  var screen: Screen
  var deviceNames: [String]

  var body: some View {
    ForEach(values: deviceNames) { device in
      ForEach(values: ColorScheme.allCases) { scheme in
        NavigationView {
          self.screen
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .previewDevice(PreviewDevice(rawValue: device))
        .colorScheme(scheme)
        .previewDisplayName("\(scheme.previewName): \(device)")
        .navigationViewStyle(StackNavigationViewStyle())
      }
    }
  }

}
