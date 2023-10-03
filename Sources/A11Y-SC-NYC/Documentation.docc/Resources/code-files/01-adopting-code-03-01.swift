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
        if let recipe = model.recipes.first(where: { $0.id == scrolledRecipe }) {
          Summary(recipe: recipe)
            .padding()
            .glassBackgroundEffect()
            .accessibilityHidden(true)
        }
      }
#endif
    }
  }
}
