import SwiftUI

struct AlmostThere: View {
  
  @Environment(OnboardingFeatureModel.self)
  private var model
  
  @AccessibilityFocusState
  var isReadyButtonFocused: Bool
  
  @State
  var progress = 1.0
  
  var body: some View {
    List {
      Section {
        VStack {
          // ...
          
          withAnimation {
            VStack(alignment: .leading, spacing: 8) {
              // ...
            }
            .padding(.top)
            .accessibilityHidden(true)
          }
        }
        .listRowSeparator(.hidden)
      } header: {
        Image(decorative: "wursthain")
        // ...
      }
    }
    .listStyle(.plain)
    .toolbar {
      //...
    }
    .task {
      Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
        progress -= Double.random(in: 0.001...0.05)
        if progress <= 0 {
          timer.invalidate()
          model.onboardingIsReady()
          isReadyButtonFocused = true
        }
      }
    }
  }
}
