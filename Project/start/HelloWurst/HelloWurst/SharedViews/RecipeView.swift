import SwiftUI

struct RecipeView: View {
  @Environment(AppCoreFeatureModel.self) private var model
  let recipe: Recipe
  
  var body: some View {
    @Bindable var model = model
    
    List {
      Section {
        Color.clear
          .aspectRatio(contentMode: .fit)
          .background {
            // This image is created with an explicit (accessibility) label.
            // TODO: create image description
            Image(decorative: recipe.image)
              .resizable()
              .aspectRatio(contentMode: .fill)
            /// > Tip: inner corner radius + padding = outer corner radius
              .mask(RoundedRectangle(cornerRadius: 8).aspectRatio(contentMode: .fit))
          }
      }
      
      RecipeSections(recipe: recipe)
    }
    .toolbar {
      ToolbarItem {
        HStack {
          Button("Love", systemImage: "heart", action: {})
          Button("Notes", systemImage: "note.text", action: {})
          Button("Share", systemImage: "square.and.arrow.up", action: {})
        }
      }
    }
    .navigationTitle(recipe.name)
    .toolbar {
      ToolbarItem(placement: .bottomBar) {
        Button(
          action: { model.displayStepByStep(recipe: recipe) },
          label: {
            Text("Preparation".uppercased())
              .frame(maxWidth: .infinity)
          }
        )
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
      }
    }
    .sheet(
      isPresented: $model.isStepByStepPresented,
      onDismiss: { model.hideStepByStep() }
    ) {
      NavigationStack {
        StepByStepView()
          .environment(StepByStepFeatureModel(steps: recipe.steps, didComplete: { model.hideStepByStep() } ))
          .toolbar {
            ToolbarItem(placement: .automatic) {
              Button(
                "Close",
                systemImage: "xmark.circle.fill",
                action: { model.hideStepByStep() }
              )
            }
          }
      }
    }
  }
}

struct RecipeSections: View {
  let recipe: Recipe
  
  var body: some View {
    Section("Recipe by:".uppercased()) {
      AuthorView(recipe: recipe)
    }
    
    Section("Servings".uppercased()) {
      ServingsPicker(size: 50)
    }
    
    Section("You need".uppercased()) {
      IngredientsView(ingredients: recipe.required)
        .fontDesign(.serif)
    }
    
    Section("You might have this at home".uppercased()) {
      IngredientsView(ingredients: recipe.mightHave)
        .fontDesign(.serif)
    }
    
    Section(
      content: {
        NutritionFactsView(recipe: recipe)
          .fontDesign(.serif)
      },
      header: {
        HStack {
          Text("Nutrition facts".uppercased())
          Spacer()
          Text("per serving (approx.)").font(.caption)
        }
        .accessibilityElement(children: .combine)
      }
    )
  }
}

// MARK: - Nutrition Facts View

struct NutritionFactsView: View {
  let recipe: Recipe
  
  var items: [GridItem] = [
    .init(.adaptive(minimum: 100))
  ]
  
  var body: some View {
    LazyVGrid(columns: items) {
      ForEach(recipe.nutritionFacts) { fact in
        switch fact.factType {
        case .calorie(let fact):
          VStack {
            Text(fact.value, format: .number).font(.title2)
            Text("Cal").font(.caption).foregroundColor(.secondary)
          }
          .fixedSize()
          .padding(24)
          .background(Circle().stroke().fill(.yellow))
          .accessibilityElement(children: .combine)
          
        case .protein(let fact):
          VStack {
            Text(fact.formatted()).font(.title2)
            Text("Protein").font(.caption).foregroundColor(.secondary)
          }
          .fixedSize()
          .padding(24)
          .background(Circle().stroke().fill(.green))
          .accessibilityElement(children: .combine)
          
        case .fat(let fact):
          VStack {
            Text(fact.formatted()).font(.title2)
            Text("Fat").font(.caption).foregroundColor(.secondary)
          }
          .fixedSize()
          .padding(24)
          .background(Circle().stroke().fill(.orange))
          .accessibilityElement(children: .combine)
          
        case .carbohydrate(let fact):
          VStack {
            Text(fact.formatted()).font(.title2)
            Text("Carb").font(.caption).foregroundColor(.secondary)
          }
          .fixedSize()
          .padding(24)
          .background(Circle().stroke().fill(.gray))
          .accessibilityElement(children: .combine)
        }
      }
    }
  }
}

// MARK: - Author View

struct AuthorView: View {
  @Environment(\.openURL) private var openURL
  let recipe: Recipe
  
  var body: some View {
    ForEach(recipe.authors) { author in
      HStack {
        Text(author.name)
        
        Spacer()
        
        Button("More info") { openURL(author.source) }
          .buttonStyle(.borderedProminent)
      }
      .accessibilityElement(children: .combine)
      .fontDesign(.serif)
    }
  }
}

// MARK: - Ingredients View

struct IngredientsView: View {
  @Environment(Preferences.self) private var preferences
  let ingredients: [Recipe.Ingredient]
  
  var body: some View {
    ForEach(ingredients) { ingredient in
      LabeledContent(
        ingredient.name,
        value: ingredient.amount.formatted(servings: preferences.servings)
      )
    }
  }
}

// MARK: - Preview

#Preview {
  NavigationStack {
    RecipeView(recipe: Recipe.mock[0])
  }
  .environment(AppCoreFeatureModel())
  .environment(Preferences())
}

#Preview {
  NavigationStack {
    RecipeView(recipe: Recipe.mock[1])
  }
  .environment(AppCoreFeatureModel())
  .environment(Preferences())
}

#Preview {
  NavigationStack {
    RecipeView(recipe: Recipe.mock[2])
  }
  .environment(AppCoreFeatureModel())
  .environment(Preferences())
}

#Preview {
  NavigationView {
    RecipeView(recipe: Recipe.mock[3])
  }
  .environment(AppCoreFeatureModel())
  .environment(Preferences())
}

#Preview {
  NavigationStack {
    List {
      Section {
        NutritionFactsView(recipe: Recipe.mock[3])
      }
    }
  }
  .environment(Preferences())
}
