import SwiftUI

struct ContentView: View {
    private let buttonColor = Color(hex: "5ab8ad")
    private let customBackgroundColor = Color(hex: "061b19")

    @State private var logoAndTitleVisible = false
    @State private var taglineVisible = false
    @State private var buttonVisible = false

    var body: some View {
        NavigationView {
            ZStack {
                customBackgroundColor.edgesIgnoringSafeArea(.all)

                VStack(spacing: 40) {
                    VStack(spacing: 10) {
                        Image("CentralLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .opacity(logoAndTitleVisible ? 1 : 0)
                            .scaleEffect(logoAndTitleVisible ? 1 : 0.8)
                            .animation(.easeInOut(duration: 1), value: logoAndTitleVisible)

                        Text("Aetheria")
                            .font(.custom("Avenir", size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(buttonColor)
                            .opacity(logoAndTitleVisible ? 1 : 0)
                            .scaleEffect(logoAndTitleVisible ? 1 : 0.8)
                            .animation(.easeInOut(duration: 1), value: logoAndTitleVisible)
                    }

                    VStack(spacing: 20) {
                        Text("Your gateway to sustainability insights")
                            .font(.custom("Avenir", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .opacity(taglineVisible ? 1 : 0)
                            .animation(.easeInOut(duration: 1), value: taglineVisible)

                        NavigationLink(destination: DialView()) {
                            Text("View Your Insights")
                                .font(.custom("Avenir", size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(buttonColor)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                                .opacity(buttonVisible ? 1 : 0)
                                .animation(.easeInOut(duration: 1).delay(0.2), value: buttonVisible)
                        }
                    }
                }
            }
            .onAppear {
                logoAndTitleVisible = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    taglineVisible = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        buttonVisible = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
