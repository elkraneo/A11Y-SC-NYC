import SwiftUI

struct Summary: View {
  
  @Environment(Preferences.self)
  var preferences
  
  @Environment(\.locale)
  var locale
  
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
#if os(visionOS)
          .foregroundColor(.primary)
          .padding(4)
          .background(Color.accentColor)
          .cornerRadius(4.0)
#elseif os(iOS)
          .foregroundColor(.accentColor)
          .background(.clear)
#endif
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
