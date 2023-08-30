import SwiftUI

struct PresentationView: View {
  @Environment(OnboardingFeatureModel.self)
  var model
  
  @Environment(\.accessibilityVoiceOverEnabled)
  var voiceOverEnabled: Bool
  
  private func cancelTimer() {
    timer.upstream.connect().cancel()
  }
  
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
    .task {
      if voiceOverEnabled {
        cancelTimer()
      }
    }
  }
}
