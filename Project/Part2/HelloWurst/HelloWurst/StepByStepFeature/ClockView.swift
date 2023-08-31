import SwiftUI
import RealityKit

#if os(visionOS)
struct ClockView: View {
  var body: some View {
    RealityView { content in
      let modelEntity = try! await ModelEntity(named: "Wall_Kitchen_Clock_50s")
      var accessibilityComponent = AccessibilityComponent()
      accessibilityComponent.isAccessibilityElement = true
      // accessibilityComponent.traits = [.button] //FIXME: crashes ?
      accessibilityComponent.label = "Clock"
      accessibilityComponent.value = "Started"
      accessibilityComponent.systemActions = [.activate]
      modelEntity.components[AccessibilityComponent.self] = accessibilityComponent
      content.add(modelEntity)
      
      AccessibilityNotification.Announcement("Game piece hit").post()
    }
    
    // Model3D(named: "Wall_Kitchen_Clock_50s")
    //   .rotation3DEffect(.degrees(-90), axis: .y)
    //   .accessibilityValue("15 minutes to go...")  //FIXME: does not work ?
  }
}

#Preview {
  ClockView()
}
#endif
