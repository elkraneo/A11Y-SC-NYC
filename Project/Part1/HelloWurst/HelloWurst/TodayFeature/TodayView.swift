import SwiftUI

struct TodayView: View {
  
  @Environment(AppCoreFeatureModel.self)
  var model
  
  @State
  var scrolledRecipe: Recipe.ID?
  
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
                Image(recipe.image)
                  .resizable()
                  .scaledToFill()
              )
              .clipped()
              .containerRelativeFrame(.horizontal)
              .containerRelativeFrame(.vertical)
            }
          }
        }
        .scrollTargetLayout()
      }
      .scrollTargetBehavior(.paging)
      .scrollPosition(id: $scrolledRecipe)
      .ignoresSafeArea()
      .task {
        scrolledRecipe = model.recipes.first?.id
      }
    }
  }
}

struct Summary: View {
  @Environment(Preferences.self) private var preferences
  @Environment(\.locale) private var locale
  let recipe: Recipe
  
  var body: some View {
    let price = (recipe.price * Double(preferences.servings))
      .formatted(.currency(code: locale.currency?.identifier ?? "EUR"))
    
    VStack(alignment: .leading) {
      Text(recipe.name)
        .font(.system(.largeTitle, design: .serif, weight: .bold))
      
      Spacer().frame(maxHeight: 60)
      
      HStack(alignment: .bottom) {
        let cookingTime = recipe.time.formatted(.units(allowed: [.minutes], width: .abbreviated))
        Label(cookingTime, systemImage: "timer")
        
        Spacer()
        
        Image(systemName: recipe.diet.systemImage)
          .font(.title)
          .opacity(0.5)
        
        Divider().overlay(.white).frame(maxHeight: 55)
        
        VStack(alignment: .leading) {
          Label(
            preferences.servings.formatted() + " Pers",
            systemImage: "person.2"
          )
          .font(.caption)
          .foregroundColor(.accentColor)
          .background(.clear)

          Text(price)
            .font(.title)
        }
      }
    }
    .padding()
    .foregroundColor(.white)
  }
}

#Preview {
  NavigationStack {
    TodayView()
      .environment(AppCoreFeatureModel(recipes: Recipe.mock))
      .environment(Preferences())
  }
}
