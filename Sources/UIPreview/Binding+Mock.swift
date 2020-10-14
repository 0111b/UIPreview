import SwiftUI

@available(iOS 13, *)
extension Binding {
  public static func mock(_ value: Value) -> Self {
    var value = value
    return Binding(get: { value }, set: { value = $0 })
  }
}

