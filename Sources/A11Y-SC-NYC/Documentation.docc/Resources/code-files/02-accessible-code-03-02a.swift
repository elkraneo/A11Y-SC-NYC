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
