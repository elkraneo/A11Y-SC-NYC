import SwiftUI

struct RecipeView: View {
  
  @Environment(AppCoreFeatureModel.self)
  var model
  
  let recipe: Recipe
  
  var body: some View {
    @Bindable var model = model
    
    List {
      Section {
        Color.clear
          .aspectRatio(contentMode: .fit)
          .background {
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
