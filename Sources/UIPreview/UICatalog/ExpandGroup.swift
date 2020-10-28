//
//  SwiftUIView.swift
//  
//
//  Created by Alexandr Goncharov on 28.10.2020.
//

import SwiftUI

@available(iOS 14, *)
struct ExpandGroup<Caption, Content>: View where Content: View, Caption: View {
  @State private var defaultIsExpanded: Bool = false
  private var isExpanded: Binding<Bool>?

  var label: () -> Caption
  var content: () -> Content

  init(isExpanded: Binding<Bool>,
       content: @escaping () -> Content,
       label: @escaping () -> Caption) {
    self.init(isExpanded: .some(isExpanded), content: content, label: label)
  }

  init<S>(_ caption: S,
          isExpanded: Binding<Bool>,
          content: @escaping () -> Content)
  where S: StringProtocol, Caption == Text {
    self.init(isExpanded: .some(isExpanded), content: content, label: { Text(caption) })
  }

  init(content: @escaping () -> Content,
       label: @escaping () -> Caption) {
    self.init(isExpanded: nil, content: content, label: label)
  }

  init<S>(_ caption: S,
          content: @escaping () -> Content)
  where S: StringProtocol, Caption == Text {
    self.init(isExpanded: nil, content: content, label: { Text(caption) })
  }

  private init(isExpanded: Binding<Bool>?,
               content: @escaping () -> Content,
               label: @escaping () -> Caption) {
    self.isExpanded = isExpanded
    self.content = content
    self.label = label
  }

  var body: some View {
    ExpandGroupImp(
      isExpanded: isExpanded ?? $defaultIsExpanded,
      label: label,
      content: content
    )
  }
}

@available(iOS 14, *)
private struct ExpandGroupImp<Caption, Content>: View where Content: View, Caption: View {
  @Binding var isExpanded: Bool

  var label: () -> Caption
  var content: () -> Content

  private var chevronImage: some View {
    Image(systemName: isExpanded
            ? "chevron.up"
            : "chevron.down")
  }

  @ViewBuilder
  var body: some View {
    VStack(alignment: .leading) {
      Button(action: {
        isExpanded.toggle()
      }, label: {
        Label(
          title: { label() },
          icon: { chevronImage }
        )
          .foregroundColor(.primary)
      })
      if isExpanded {
        content()
          .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
      }
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color(.systemGroupedBackground))
    .cornerRadius(6)
    .padding()
  }
}

@available(iOS 14, *)
struct ExpandGroup_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/) {
      ExpandGroup {
        Text("Content")
      } label: {
        Text("Caption")
      }
      Spacer()
    }
  }
}
