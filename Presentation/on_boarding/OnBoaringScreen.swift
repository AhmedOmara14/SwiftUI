import SwiftUI

struct OnBoaringScreen: View {
    var onTapGetStarted: () -> Void
    var body: some View {
        ZStack {
            Image("OnBoardingImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            LinearGradient(
                colors: [.clear, Color.black.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 16) {

                    Text("Welcome To MovieWorld")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.textPrimary)
                        .multilineTextAlignment(.center)

                    Text("The best movie streaming app of the century to make your days great.")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)

                    Button(action: {
                        onTapGetStarted()
                    }) {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accent)
                            .cornerRadius(24)
                    }
                }
                .padding(.horizontal, 35)
                .padding(.bottom, 40)
            }.safeAreaPadding(.horizontal, 35)

        }
    }
}

