import SwiftUI

struct OnboardingStepView: View {
  let title: String
  let subtitle: String
  let imageName: String
  
  var body: some View {
    ZStack {
      Color.clear
        .background {
          // TODO: create image description
          Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .offset(y: -12)
        }
      
      VStack {
        Text(title)
          .font(.system(.title, design: .serif))
          .bold()
        
        Text(subtitle)
        
        Spacer()
      }
      .foregroundColor(.white)
      .padding(.vertical, 32)
      .multilineTextAlignment(.center)      
    }
  }
}



#Preview {
  OnboardingStepView(
    title: "Hello Würst! Quick & healthy recipes incoming!",
    subtitle: "Discover new recipes everyday — for free!",
    imageName: "agnieszka-kowalczyk-obMdrL5pFWI-unsplash"
  )
}
