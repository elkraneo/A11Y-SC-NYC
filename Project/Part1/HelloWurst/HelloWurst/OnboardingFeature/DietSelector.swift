import SwiftUI

struct DietSelector: View {
  
  @Environment(OnboardingFeatureModel.self) 
  var model
  
  @Environment(Preferences.self) 
  var preferences
  
  var body: some View {
    List {
      Section {
        ForEach(Diet.allCases) { diet in
          let isSelected = diet == preferences.diet
          Button(
            action: { preferences.diet = diet },
            label: {
              HStack {
                Label(diet.rawValue, systemImage: diet.systemImage)
                if diet.isIncludedInFreeVersion {
                  Spacer()
                  Text("Included in free version".uppercased()).font(.caption2)
                    .padding(3)
                    .background(RoundedRectangle(cornerRadius: 3).fill(Color.secondary.opacity(0.2)))
                }
              }
            }
          )
          .tag(diet)
          .listItemTint(isSelected ? Color.primary : .accentColor)
          .listRowBackground(isSelected ? Color.accentColor : .clear )
          .listRowSeparator(.hidden)
        }
      } header: {
        VStack {
          Spacer()
            .frame(width: .zero, height: 0)
          
          Text("What's your diet?")
            .font(.system(.title, design: .serif))
            .bold()
          
          Text("The free version includes the first 2 options.")
            .fontWeight(.regular)
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.primary)
        .padding(.bottom, 30)
        .multilineTextAlignment(.center)
      }
    }
    .listStyle(.plain)
    .toolbar {
      ToolbarItem(placement: .bottomBar) {
        Button(
          action: { model.displayServingsCounter() },
          label: {
            Text("Continue".uppercased())
              .bold()
              .frame(maxWidth: .infinity)
          }
        )
        .disabled(preferences.diet == nil)
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
      }
    }
    .toolbar {
      ToolbarItem {
        Button("Skip") { model.displayServingsCounter() }
      }
    }
  }
}

#Preview {
  NavigationStack {
    DietSelector()
      .environment(OnboardingFeatureModel())
      .environment(Preferences())
  }
}
