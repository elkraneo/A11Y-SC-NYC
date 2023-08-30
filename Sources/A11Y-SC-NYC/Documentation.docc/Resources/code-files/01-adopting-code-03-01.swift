import SwiftUI

struct TodayView: View {
  
  @Environment(AppCoreFeatureModel.self)
  var model
  
  var body: some View {
    NavigationStack {
      ScrollView {
        // ...
      }
#if os(visionOS)
      .ornament(
        visibility: model.isOnboadingPresented ? .hidden : .visible,
        attachmentAnchor: .scene(.bottom)
      ) {
        Summary(recipe: recipe)
          .padding()
          .glassBackgroundEffect()
          .accessibilityHidden(true)
      }
#endif
    }
  }
}
