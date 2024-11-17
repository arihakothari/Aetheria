import SwiftUI

struct Blueprint: View {
    @State private var selectedIssue: BuildingIssue? = nil
    @State private var showDetailedView: Bool = false

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(hex: "061b19"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor(Color(hex: "5ab8ad"))
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("Building Map")
                    .font(Font.custom("Avenir", size: 26))
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(height: 40) // Shortened header height
            .background(Color(hex: "061b19"))
            
            ScrollView {
                VStack(spacing: 0) {
                    // Floor plan container with rounded corners
                    VStack {
                        Image("blueprint")
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(30)
                            .shadow(radius: 10)
                            .overlay(
                                Group {
                                    if !showDetailedView {
                                        ForEach(buildingIssues) { issue in
                                            MapMarker(issue: issue)
                                                .transition(.opacity.combined(with: .scale(scale: 0.8)))
                                                .animation(.easeInOut(duration: 0.2))
                                                .onTapGesture {
                                                    withAnimation(.easeInOut) {
                                                        selectedIssue = issue
                                                        showDetailedView = true
                                                    }
                                                }
                                        }
                                    }
                                }
                            )
                            .onTapGesture {
                                if showDetailedView {
                                    withAnimation(.easeInOut) {
                                        showDetailedView = false
                                        selectedIssue = nil
                                    }
                                }
                            }
                            .padding(.horizontal, 15)
                            .frame(height: showDetailedView ? UIScreen.main.bounds.height * 0.35 : UIScreen.main.bounds.height * 0.55)
                            .padding(.bottom, showDetailedView ? 10 : 20)
                            .transition(.scale)
                    }
                    
                    // AI Suggestions Section with animation
                    if let issue = selectedIssue, showDetailedView {
                        AISection(issue: issue, showDetailedView: $showDetailedView)
                            .padding()
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut, value: selectedIssue)
                            .background(Color(hex: "061b19"))
                    } else {
                        VStack {
                            Text("Tap on a colored dot to see details and AI suggestions.")
                                .font(Font.custom("Avenir", size: 18))
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .background(Color(hex: "061b19"))
        }
        .background(Color(hex: "061b19").ignoresSafeArea())
//        .navigationBarBackButtonHidden(true)
    }
}

struct BuildingIssue: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let description: String
    let suggestions: [String]
    let savings: String
    let position: CGPoint
}

let buildingIssues = [
    BuildingIssue(
        name: "Water Leak",
        description: "Leak detected in the restroom.",
        suggestions: [
            "Repair visible leaks in pipes.",
            "Install low-flow faucets.",
            "Monitor water usage for early detection."
        ],
        savings: "Potential yearly savings: $800",
        position: CGPoint(x: 0.81, y: 0.44)
    ),
    BuildingIssue(
        name: "Lighting Overuse",
        description: "Lights left on in unoccupied rooms.",
        suggestions: [
            "Install motion sensors.",
            "Switch to LED lighting.",
            "Educate staff on turning off lights."
        ],
        savings: "Potential yearly savings: $600",
        position: CGPoint(x: 0.75, y: 0.2)
    ),
    BuildingIssue(
        name: "Inefficient Cooling",
        description: "Inefficient cooling in the server room.",
        suggestions: [
            "Optimize cooling settings.",
            "Seal gaps to prevent air leaks.",
            "Use cold aisle containment."
        ],
        savings: "Potential yearly savings: $1,500",
        position: CGPoint(x: 0.15, y: 0.7)
    )
]

struct MapMarker: View {
    let issue: BuildingIssue
    
    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 20, height: 20)
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 3)
            .position(x: issue.position.x * UIScreen.main.bounds.width,
                      y: issue.position.y * UIScreen.main.bounds.height * 0.5)
    }
}

struct AISection: View {
    let issue: BuildingIssue
    @Binding var showDetailedView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(issue.name)
                .font(Font.custom("Avenir", size: 22))
                .bold()
                .foregroundColor(.white)
            
            Text(issue.description)
                .font(Font.custom("Avenir", size: 16))
                .foregroundColor(.white.opacity(0.8))
            
            Divider().background(Color.white.opacity(0.7))
            
            Text("AI Suggestions")
                .font(Font.custom("Avenir", size: 18))
                .bold()
                .foregroundColor(.white)
            
            ForEach(issue.suggestions, id: \.self) { suggestion in
                HStack(alignment: .top) {
                    Text("•")
                        .font(Font.custom("Avenir", size: 16))
                        .foregroundColor(.white.opacity(0.7))
                    Text(suggestion)
                        .font(Font.custom("Avenir", size: 16))
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            
            let savingsComponents = issue.savings.components(separatedBy: ": ")
            if savingsComponents.count == 2 {
                (
                    Text(savingsComponents[0] + ": ")
                        .font(Font.custom("Avenir", size: 18))
                        .foregroundColor(Color(hex: "68ea5b")) +
                    Text(savingsComponents[1])
                        .font(Font.custom("Avenir", size: 18))
                        .bold()
                        .foregroundColor(Color(hex: "68ea5b"))
                )
                .padding(.top, 5)
            } else {
                Text(issue.savings)
                    .font(Font.custom("Avenir", size: 18))
                    .foregroundColor(Color(hex: "68ea5b"))
                    .padding(.top, 5)
            }
            
            Button(action: {
                print("Implement AI solution")
            }) {
                Text("View Full Breakdown")
                    .font(Font.custom("Avenir", size: 18))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "5ab8ad"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color(hex: "1c3c43"))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}


extension Color {
    static func fromHex(_ hex: String) -> Color {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        return Color(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
