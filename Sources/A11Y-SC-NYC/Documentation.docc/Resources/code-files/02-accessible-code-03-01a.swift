import SwiftUI

struct TodayView: View {
  
  @Environment(AppCoreFeatureModel.self)
  var model
  
  @State
  var scrolledRecipe: Recipe.ID?
  
  @State
  var displayOrnament = false
  
  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVStack(spacing: 0.0) {
          ForEach(model.recipes) { recipe in
            NavigationLink(destination: RecipeView(recipe: recipe)) {
              VStack {
                Spacer()
#if os(visionOS)
                Color.clear
#elseif os(iOS)
                Summary(recipe: recipe)
                  .padding(.horizontal)
                  .background(.black.opacity(0.5))
                  .padding(.bottom, 80)
                  .accessibilityHidden(true)
#endif
              }
              .background(
                Image(decorative: recipe.image)
                  .resizable()
                  .scaledToFill()
              )
              .clipped()
              .containerRelativeFrame(.horizontal)
              .containerRelativeFrame(.vertical)
              .accessibilityRepresentation {
                Summary(recipe: recipe)
              }
              .hoverEffect()
            }
          }
        }
        .scrollTargetLayout()
      }
      .scrollTargetBehavior(.paging)
      .scrollPosition(id: $scrolledRecipe)
      .ignoresSafeArea()
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
      .task {
        scrolledRecipe = model.recipes.first?.id
        displayOrnament = true
      }
    }
  }
}
