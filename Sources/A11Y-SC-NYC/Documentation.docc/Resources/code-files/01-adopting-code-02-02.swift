import SwiftUI

struct TodayView: View {
  
  @Environment(AppCoreFeatureModel.self)
  var model
  
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
      }
    }
  }
}
