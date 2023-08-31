import SwiftUI

struct PresentationView: View {
  
  @Environment(OnboardingFeatureModel.self)
  var model
  
  private let timer = Timer.publish(every: 5, tolerance: 0.5, on: .main, in: .common).autoconnect()
  
  private func cancelTimer() {
    timer.upstream.connect().cancel()
  }
  
  var body: some View {
    @Bindable var model = model
    let swipeToStopTimer = DragGesture()
      .onChanged { _ in
        cancelTimer()
      }
    
    TabView(selection: $model.currentSlide) {
      OnboardingStepView(
        title: "Hello Würst! Quick & healthy recipes incoming!",
        subtitle: "Discover new recipes everyday — for free!",
        imageName: "agnieszka-kowalczyk-obMdrL5pFWI-unsplash"
      )
      .tabItem { Text("Hello") }
      .tag(0)
      
      OnboardingStepView(
        title: "Get personalized recipes",
        subtitle: "Choose between 9 different diets & leave out ingredients you don't eat.",
        imageName: "benjamin-kaufmann-sb3Cv_K14Js-unsplash"
      )
      .tabItem { Text("Personalized") }
      .tag(1)
      
      OnboardingStepView(
        title: "Find recipes based on ingredients",
        subtitle: "Use up leftover ingredients with our `Fridge Finds` feature",
        imageName: "ratul-ghosh-NPrWYa69Mz0-unsplash"
      )
      .tabItem { Text("Find") }
      .tag(2)
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .animation(.default, value: model.currentSlide)
    .overlay(alignment: .bottom) {
      VStack {
        Button(
          action: { model.displayGoalsSelector() },
          label: {
            Text("Let's get started".uppercased())
              .bold()
              .frame(maxWidth: .infinity)
          }
        )
        .buttonStyle(.borderedProminent)
        .controlSize(.extraLarge)
        
        Text(
          """
          By continuing, I agree to Hello Würst's [Terms of Use](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
          and [Privacy Policy](https://www.youtube.com/watch?v=CduA0TULnow)
          """
        )
        .font(.footnote)
        .multilineTextAlignment(.center)
      }
      .foregroundColor(.white)
      .padding(.horizontal)
      .padding(.bottom, 60)
    }
    .onReceive(timer) { _ in
      model.nextSlide()
    }
    .gesture(swipeToStopTimer)
  }
}

#Preview {
  PresentationView()
    .environment(OnboardingFeatureModel())
}