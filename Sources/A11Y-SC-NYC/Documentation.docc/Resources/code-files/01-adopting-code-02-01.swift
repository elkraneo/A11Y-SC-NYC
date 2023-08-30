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
                
                Summary(recipe: recipe)
                  .padding(.horizontal)
                  .background(.black.opacity(0.5))
                  .padding(.bottom, 80)
              }
              .background(
                Image(decorative: recipe.image)
                  .resizable()
                  .scaledToFill()
              )
              .clipped()
              .containerRelativeFrame(.horizontal)
              .containerRelativeFrame(.vertical)
              .hoverEffect()
            }
          }
        }
      }
    }
  }
}
