import SwiftUI
import MapKit

// Extensions for Color initialization using hex
//extension Color {
//    init(hex: String) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int: UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (255, 0, 0, 0)
//        }
//        self.init(
//            .sRGB,
//            red: Double(r) / 255,
//            green: Double(g) / 255,
//            blue: Double(b) / 255,
//            opacity: Double(a) / 255
//        )
//    }
//}

// Constants
let customBackgroundColor = Color(hex: "061b19")
let containerColor = Color(hex: "396261")
let lightBlueColor = Color(hex: "#D1E9EA")

enum ProblemType {
    case electricity
    case waterUsage
    case hvac
    case none
}

// Models
struct ProblemArea: Identifiable {
    let id = UUID()
    let name: String
    let type: ProblemType
    let concernLevel: Double
    let description: String
}

// Views
struct DialView: View {
    @State private var sustainabilityScore: Double = 0
    @State private var animatedScore: Int = 0
    @State private var showScoreLabel = false
    @State private var problematicAreas: [ProblemArea] = []

    var body: some View {
        //NavigationView {
            VStack(spacing: 0) {
                // Top Half
                VStack {
                    ZStack {
                        Circle()
                            .trim(from: 0.0, to: 0.5)
                            .stroke(
                                Color.gray.opacity(0.3),
                                style: StrokeStyle(lineWidth: 50, lineCap: .round)
                            )
                            .rotationEffect(.degrees(180))
                            .padding(.top, 25)

                        Circle()
                            .trim(from: 0.0, to: CGFloat(sustainabilityScore / 100) * 0.5)
                            .stroke(
                                lightBlueColor, // Light blue color for the speedometer
                                style: StrokeStyle(lineWidth: 50, lineCap: .round)
                            )
                            .rotationEffect(.degrees(180))
                            .animation(.easeInOut(duration: 1), value: sustainabilityScore)
                            .padding(.top, 25)

                        VStack {
                            Spacer()
                                .frame(height: 100)

                            Text(scoreLabel)
                                .font(.custom("Avenir", size: 45))
                                .fontWeight(.bold)
                                .foregroundColor(scoreColor)
                                .opacity(showScoreLabel ? 1 : 0) // Apply opacity for fade-in
                                .animation(.easeInOut(duration: 1).delay(0.05), value: showScoreLabel)

                            Text("Sustainability Score: \(animatedScore)%")
                                .font(.custom("Avenir", size: 21))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 250, height: 250)

                    // Updated NavigationLink to Blueprint
                    NavigationLink(destination: Blueprint()) {
                        Text("View Map")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 25)
                            .background(Color(hex: "5ab8ad")) // Button color
                            .cornerRadius(8)
                    }
                    .padding(.top, 1)
                }
                .frame(height: 320)

                // Bottom Half
                VStack {
                    Text(" ⚠️ \(problematicAreas.filter { $0.concernLevel >= 40 }.count) potential fixes ")
                        .font(.custom("Avenir", size: 21))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    List(problematicAreas.sorted(by: { $0.concernLevel > $1.concernLevel })) { area in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .top, spacing: 15) {
                                Circle()
                                    .fill(severityColor(for: area.concernLevel))
                                    .frame(width: 21, height: 27)

                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    Text(area.name)
                                        .font(.custom("Avenir", size: 18))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text(area.description)
                                        .font(.custom("Avenir", size: 14))
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                Spacer()
                            }
                            
                            if area.type != .none {
                                NavigationLink {
                                    switch area.type {
                                    case .electricity:
                                        ElectricityUsageDetailView()
                                    case .waterUsage:
                                        WaterLeakDetailView()
                                    case .hvac:
                                        HVACDetailView()
                                    default: EmptyView()
                                    }
                                } label: {
                                    Text("View Details")
                                        .font(.custom("Avenir", size: 16))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                        .background(containerColor) // Updated container color
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
                        .background(containerColor) 
                        .cornerRadius(10)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                }
                .frame(maxHeight: .infinity) // Bottom half takes remaining space
            }
            .background(customBackgroundColor.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Sustainability Overview")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(lightBlueColor) // Light blue color for the title
                }
            }
            .onAppear {
                startScoreAnimation()
                loadDataAndAnalyze()
            }
        }
    //}

    private var scoreLabel: String {
        switch sustainabilityScore {
        case 0..<40: return "Low"
        case 40..<70: return "Medium"
        default: return "High"
        }
    }

    private var scoreColor: Color {
        switch sustainabilityScore {
        case 0..<40: return .red
        case 40..<70: return .yellow
        default: return .green
        }
    }

    private func severityColor(for concernLevel: Double) -> Color {
        switch concernLevel {
        case 70...100:
            return Color(hex: "#F3295E")
        case 40..<70:
            return Color(hex: "#EAF331")
        default:
            return Color(hex: "#B5F43F")
        }
    }

    private func startScoreAnimation() {
        let targetScore = 75
        let stepDuration = 0.02
        Timer.scheduledTimer(withTimeInterval: stepDuration, repeats: true) { timer in
            if animatedScore < targetScore {
                animatedScore += 1
            } else {
                timer.invalidate()
                withAnimation {
                    showScoreLabel = true
                }
            }
        }
    }

    func loadDataAndAnalyze() {
        sustainabilityScore = 75
        problematicAreas = [
            ProblemArea(name: "Electricity Usage", type: .electricity, concernLevel: 80,
                        description: "High electricity consumption detected during peak hours."),
            ProblemArea(name: "Water Usage", type: .waterUsage, concernLevel: 60, description: "Increased water usage compared to last month."),
            ProblemArea(name: "HVAC Efficiency", type: .hvac, concernLevel: 50, description: "HVAC systems are operating below optimal efficiency."),
            ProblemArea(name: "Waste Management", type: .none, concernLevel: 30, description: "Waste levels are within acceptable ranges.")
        ]
    }
}

struct DetailsView: View {
    let problemArea: ProblemArea

    var body: some View {
        VStack {
            Text(problemArea.name)
                .font(.custom("Avenir", size: 24))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            Text(problemArea.description)
                .font(.custom("Avenir", size: 18))
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Spacer()
        }
        .padding()
        .background(customBackgroundColor.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    DialView()
}
