import SwiftUI
import RealityKit

#if os(visionOS)
struct ClockView: View {
  var body: some View {
    Model3D(named: "Wall_Kitchen_Clock_50s")
  }
}

#Preview {
  ClockView()
}
#endif
