import SwiftUI

struct AlmostThere: View {
  
  @Environment(OnboardingFeatureModel.self)
  var model

  @AccessibilityFocusState
  var isReadyButtonFocused: Bool
    
  @State
  var progress = 1.0
  
  var body: some View {
    List {
      Section {
        VStack {
          withAnimation {
            Text(model.isReady ? "Ready to go!" : "You're almost there!")
              .font(.system(.title, design: .serif))
              .bold()
              .multilineTextAlignment(.center)
              .animation(.default, value: model.isReady)
          }
          
          Spacer()
          
          withAnimation {
            VStack(alignment: .leading, spacing: 8) {
              let isFirstStepCompleted = progress < 0.8
              Label("Finding recipes for your diet", systemImage: "checkmark.circle.fill")
                .foregroundStyle(.primary, isFirstStepCompleted ? Color.accentColor : .secondary)
                .opacity(isFirstStepCompleted ? 1 : 0.25)
                .animation(.easeInOut, value: progress)
                .offset(y: isFirstStepCompleted ? -5 : 0)
              
              let isSecondStepCompleted = progress < 0.5
              Label("Sorting out ingredients you don't eat", systemImage: "checkmark.circle.fill")
                .foregroundStyle(.primary, isSecondStepCompleted ? Color.accentColor : .secondary)
                .opacity(isSecondStepCompleted ? 1 : 0.25)
                .animation(.easeInOut, value: progress)
                .offset(y: isSecondStepCompleted ? -5 : 0)
              
              let isThirdStepCompleted = progress < 0.2
              Label("Personalizing your recipes", systemImage: "checkmark.circle.fill")
                .foregroundStyle(.primary, isThirdStepCompleted ? Color.accentColor: .secondary)
                .opacity(isThirdStepCompleted ? 1 : 0.25)
                .animation(.easeInOut, value: progress)
                .offset(y: isThirdStepCompleted ? -5 : 0)
            }
            .padding(.top)
            .accessibilityHidden(true)
          }
        }
        .listRowSeparator(.hidden)
      } header: {
        Image(decorative: "wursthain")
          .resizable()
          .scaledToFit()
          .clipShape(Circle())
          .shadow(radius: 5)
          .overlay {
            withAnimation {
              Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 16.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.accentColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut, value: progress)
            }
          }
          .padding()
      }
    }
    .listStyle(.plain)
    .toolbar {
      ToolbarItem(placement: .bottomBar) {
        Button(
          action: { model.onboardingDidComplete() },
          label: {
            Text(model.isReady ? "Finally".uppercased() : "Processing...".uppercased())
              .bold()
              .frame(maxWidth: .infinity)
          }
        )
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
        .disabled(!model.isReady)
      }
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
