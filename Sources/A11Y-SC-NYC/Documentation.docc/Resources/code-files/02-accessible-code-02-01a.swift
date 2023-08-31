import SwiftUI

struct ServingsPicker: View {
  
  @Environment(Preferences.self)
  var preferences

  var size: CGFloat = 100

  var body: some View {
    @Bindable var preferences = preferences
    
    let shape = RoundedRectangle(cornerRadius: size / 3)

    HStack {
      // ...
    }
    .padding(8)
    .background { shape.fill(Color.primary).colorInvert() }
    .overlay { shape.stroke(.secondary) }
  }
}
