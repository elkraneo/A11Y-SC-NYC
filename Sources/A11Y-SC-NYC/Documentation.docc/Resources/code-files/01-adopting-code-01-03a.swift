import SwiftUI

struct PresentationView: View {
  @Environment(OnboardingFeatureModel.self)
  var model
  
  var body: some View {
    TabView(selection: $model.currentSlide) {
      // ...
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .animation(.default, value: model.currentSlide)
    .overlay(alignment: .bottom) {
      // ...
    }
  }
}

