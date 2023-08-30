import SwiftUI

struct TodayView: View {
  @Environment(AppCoreFeatureModel.self)
  private var model
  
  @Environment(\.accessibilityVoiceOverEnabled)
  private var voiceOverEnabled: Bool
  
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
                
                Summary(recipe: recipe)
                  .padding(.horizontal)
                  .background(.black.opacity(0.5))
                  .padding(.bottom, 80)
                  .accessibilityHidden(true)
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
              .accessibilityAction(named: "Love") { print("Love") }
              .accessibilityAction(named: "Notes") { print("Notes") }
              .accessibilityAction(named: "Share") { print("Share") }
              .hoverEffect()
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
        displayOrnament = true
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
          .accessibilityLabel("Cooking time \(cookingTime)")
        
        Spacer()
        
        Image(systemName: recipe.diet.systemImage)
          .font(.title)
          .opacity(0.5)
          .accessibilityLabel("Diet: \(recipe.diet.rawValue)")
          .accessibilitySortPriority(-1)
        
        Divider().overlay(.white).frame(maxHeight: 55)
        
        VStack(alignment: .leading) {
          Label(
            preferences.servings.formatted() + " Pers",
            systemImage: "person.2"
          )
          .font(.caption)
          .accessibilityHidden(true)
          .foregroundColor(.accentColor)
          .background(.clear)
          
          Text(price)
            .font(.title)
            .accessibilityLabel("Estimated cost \(price) for \(preferences.servings) persons")
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