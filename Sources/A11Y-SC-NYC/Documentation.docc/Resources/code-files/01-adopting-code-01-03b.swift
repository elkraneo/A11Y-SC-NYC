import SwiftUI

struct PresentationView: View {
  @Environment(OnboardingFeatureModel.self)
  var model
  
  private let timer = Timer.publish(every: 5, tolerance: 0.5, on: .main, in: .common).autoconnect()
  
  var body: some View {
    TabView(selection: $model.currentSlide) {
      // ...
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .animation(.default, value: model.currentSlide)
    .overlay(alignment: .bottom) {
      // ...
    }
    .onReceive(timer) { _ in
      model.nextSlide()
    }
  }
}
