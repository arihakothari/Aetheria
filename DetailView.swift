//
//  ContentView.swift
//  Aetheria
//
//  Created by Arnav Jain on 11/16/24.
//
import SwiftUI
import Charts // Requires iOS 16 or later
// MARK: - Main ContentView
struct DetailView: View {
    init() {
        // Set navigation bar title color to white globally
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
//        NavigationView {
            VStack {
                NavigationLink(destination: ElectricityUsageDetailView()) {
                    Text("View Details")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#396261"))
                        .cornerRadius(10)
                }
                .padding()
                NavigationLink(destination: WaterLeakDetailView()) {
                    Text("View Details")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#396261"))
                        .cornerRadius(10)
                }
                .padding()
                NavigationLink(destination: HVACDetailView()) {
                    Text("View Details")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#396261"))
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Issues")
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
//    }
}
// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1.0
        )
    }
    // Custom Colors
    static let lightTurquoise = Color(hex: "#98D1CC")
    static let customGreen = Color(hex: "#006400")
    static let customPurple = Color(hex: "#3E275E")
    static let customBlue = Color(hex: "#5E272B")
    static let customOrange = Color(hex: "#78787F")
}
// MARK: - HVACDetailView
struct HVACDetailView: View {
    init() {
        // Set navigation bar title color to white
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // Existing properties and helper functions
    // Set the installation date to 01/01/2015 for this example
    let installationDate = Calendar.current.date(from: DateComponents(year: 2015, month: 1, day: 1))!
    // Current date
    let currentDate = Date()
    // Selected time period for emissions increase
    @State private var selectedPeriod = "Last Year"
    // Options for the dropdown
    let timePeriods = ["Last Year", "Last Month", "Yesterday"]
    // DataLoader instance to load data
    let dataLoader = DataLoader()
    // Energy consumption breakdown
    let energyBreakdown = [
        EnergyConsumption(category: "HVAC", percentage: 40),
        EnergyConsumption(category: "Lighting", percentage: 25),
        EnergyConsumption(category: "Equipment", percentage: 20),
        EnergyConsumption(category: "Other", percentage: 15)
    ]
    // Benchmarking data
    let industryAverageEmissions = 8.0 // Tons CO₂ per year
    let buildingEmissions = 10.0       // Tons CO₂ per year
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Problem Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Problem")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Energy 💨")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("Ineficient server room cooling system reducing energy efficiency")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Solution Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Solution")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Upgrade ⬆️")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("Upgrade to a modern, energy-efficient cooling system to improve performance and reduce energy consumption.")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Installation Date and Age
                VStack(alignment: .leading, spacing: 5) {
                    Text("Installation Date")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Installed 🔨")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text("Installed on ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("\(formattedDate(installationDate))")
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Text("System Age: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("\(String(format: "%.1f", hvacAge())) years")
                                    .foregroundColor(.white)
                            }
                        }
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Estimated Emissions Offset
                VStack(alignment: .leading, spacing: 5) {
                    Text("Estimated Emissions Offset")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Carbon Offset 🌿")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("\(String(format: "%.2f", calculateEmissionsOffset())) tons CO₂ per year")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Cost-Benefit Analysis Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Cost-Benefit Analysis")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Financial 💰")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text("Estimated Upgrade Cost: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("$50,000")
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Text("Estimated Annual Savings: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("$15,000")
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Text("Payback Period: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("\(String(format: "%.1f", calculatePaybackPeriod())) years")
                                    .foregroundColor(.white)
                            }
                        }
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Emissions Increase
                VStack(alignment: .leading, spacing: 5) {
                    Text("Emissions Increase")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    // Chart Container with "Offset ％"
                    chartContainerView {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 5) {
                                Text("Offset Graph")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.lightTurquoise)
                            }
                            .padding(.bottom, 5)
                            Picker("Select Time Period", selection: $selectedPeriod) {
                                ForEach(timePeriods, id: \.self) { period in
                                    Text(period)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.vertical)
                            Text("Since \(selectedPeriod): \(simulateEmissionsIncrease(), specifier: "%.2f") tons CO₂")
                                .font(.headline)
                                .foregroundColor(.white)
                            EmissionsChart(selectedPeriod: $selectedPeriod)
                                .frame(height: 200)
                                .padding(.top)
                        }
                    }
                }
                // Energy Consumption Breakdown
                VStack(alignment: .leading, spacing: 5) {
                    Text("Energy Consumption Breakdown")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    // Chart Container with "Breakdown %"
                    chartContainerView {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 5) {
                                Text("Breakdown")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.lightTurquoise)
                            }
                            .padding(.bottom, 5)
                            EnergyBreakdownChart(energyData: energyBreakdown)
                                .frame(height: 200)
                                .padding(.top)
                        }
                    }
                }
                // Benchmarking Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Benchmarking")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Emissions 🔥")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("Your building's emissions are \(buildingEmissions, specifier: "%.2f") tons CO₂ per year, which is \(buildingEmissions - industryAverageEmissions, specifier: "%.2f") tons higher than the industry average.")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.bottom)
                        BenchmarkingChart(buildingEmissions: buildingEmissions, industryAverage: industryAverageEmissions)
                            .frame(height: 200)
                            .padding(.top)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .background(Color(hex: "#061b19").edgesIgnoringSafeArea(.all))
        .navigationTitle("Inefficient Cooling")
        .navigationBarTitleDisplayMode(.inline)
    }
    // Helper function to create container views without titles
    func containerView(content: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(content)
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#396261"))
        .cornerRadius(10)
    }
    // Helper function to create chart container views without titles
    @ViewBuilder
    func chartContainerView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#396261"))
        .cornerRadius(10)
    }
    // Calculations and Helpers
    func hvacAge() -> Double {
        let components = Calendar.current.dateComponents([.day], from: installationDate, to: currentDate)
        let days = Double(components.day ?? 0)
        let years = days / 365.25
        return max(years, 0)
    }
    func calculateEmissionsOffset() -> Double {
        let age = hvacAge()
        let hvacAges = dataLoader.dataPoints.map { $0.hvacAge }
        let emissionsOffsets = dataLoader.dataPoints.map { $0.emissionsOffset }
        // Ensure that the data arrays are not empty
        guard hvacAges.count > 1, emissionsOffsets.count > 1 else {
            print("Not enough data points for regression.")
            return 0.0
        }
        // Check for variability in data
        let hvacAgesSet = Set(hvacAges)
        if hvacAgesSet.count == 1 {
            print("HVAC Ages have no variability.")
            return 0.0
        }
        // Perform linear regression using the dataset
        if let (slope, intercept) = linearRegression(xs: hvacAges, ys: emissionsOffsets) {
            let emissionsOffset = slope * age + intercept
            return max(emissionsOffset, 0) // Ensure the result is non-negative
        } else {
            print("Linear regression failed.")
            return 0.0
        }
    }
    func calculatePaybackPeriod() -> Double {
        let upgradeCost = 50000.0 // in dollars
        let annualSavings = 15000.0 // in dollars
        return upgradeCost / annualSavings
    }
    func linearRegression(xs: [Double], ys: [Double]) -> (slope: Double, intercept: Double)? {
        let n = Double(xs.count)
        guard n > 1 else { return nil }
        let sumX = xs.reduce(0, +)
        let sumY = ys.reduce(0, +)
        let sumXY = zip(xs, ys).map(*).reduce(0, +)
        let sumXSquare = xs.map { $0 * $0 }.reduce(0, +)
        let sumXSquared = sumX * sumX
        let denominator = n * sumXSquare - sumXSquared
        guard abs(denominator) > Double.ulpOfOne else { return nil }
        let slope = (n * sumXY - sumX * sumY) / denominator
        let intercept = (sumY - slope * sumX) / n
        return (slope, intercept)
    }
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    func simulateEmissionsIncrease() -> Double {
        // Simulate emissions increase based on selectedPeriod
        switch selectedPeriod {
        case "Last Year":
            return 10.0
        case "Last Month":
            return 3.0
        case "Yesterday":
            return 0.5
        default:
            return 0.0
        }
    }
}
// MARK: - ElectricityUsageDetailView
struct ElectricityUsageDetailView: View {
    init() {
        // Set navigation bar title color to white
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // Reuse properties and helper functions similar to HVACDetailView
    @State private var selectedPeriod = "Last Year"
    let timePeriods = ["Last Year", "Last Month", "Yesterday"]
    let dataLoader = DataLoader()
    let energyBreakdown = [
        EnergyConsumption(category: "HVAC", percentage: 30),
        EnergyConsumption(category: "Lighting", percentage: 35),
        EnergyConsumption(category: "Equipment", percentage: 25),
        EnergyConsumption(category: "Other", percentage: 10)
    ]
    let industryAverageEmissions = 12.0 // Tons CO₂ per year
    let buildingEmissions = 15.0        // Tons CO₂ per year
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Problem Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Problem")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Electricity ⚡️")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("High electricity usage due to lighting overuse and inefficient fixtures.")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Solution Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Solution")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Optimize 💡")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("Implement energy-efficient lighting fixtures and optimize usage to reduce electricity consumption.")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Estimated Emissions Offset
                VStack(alignment: .leading, spacing: 5) {
                    Text("Estimated Emissions Offset")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Carbon Offset 🌿")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("\(String(format: "%.2f", calculateEmissionsOffset())) tons CO₂ per year")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Cost-Benefit Analysis Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Cost-Benefit Analysis")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Financial 💰")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text("Estimated Upgrade Cost: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("$40,000")
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Text("Estimated Annual Savings: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("$10,000")
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Text("Payback Period: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("\(String(format: "%.1f", calculatePaybackPeriod())) years")
                                    .foregroundColor(.white)
                            }
                        }
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Emissions Increase
                VStack(alignment: .leading, spacing: 5) {
                    Text("Emissions Increase")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    // Chart Container with "Offset ％"
                    chartContainerView {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 5) {
                                Text("Offset Graph")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.lightTurquoise)
                            }
                            .padding(.bottom, 5)
                            Picker("Select Time Period", selection: $selectedPeriod) {
                                ForEach(timePeriods, id: \.self) { period in
                                    Text(period)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.vertical)
                            Text("Since \(selectedPeriod): \(simulateEmissionsIncrease(), specifier: "%.2f") tons CO₂")
                                .font(.headline)
                                .foregroundColor(.white)
                            EmissionsChart(selectedPeriod: $selectedPeriod)
                                .frame(height: 200)
                                .padding(.top)
                        }
                    }
                }
                // Energy Consumption Breakdown
                VStack(alignment: .leading, spacing: 5) {
                    Text("Energy Consumption Breakdown")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    // Chart Container with "Breakdown %"
                    chartContainerView {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 5) {
                                Text("Breakdown")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.lightTurquoise)
                            }
                            .padding(.bottom, 5)
                            EnergyBreakdownChart(energyData: energyBreakdown)
                                .frame(height: 200)
                                .padding(.top)
                        }
                    }
                }
                // Benchmarking Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Benchmarking")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Emissions 🔥")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("Your building's emissions are \(buildingEmissions, specifier: "%.2f") tons CO₂ per year, which is \(buildingEmissions - industryAverageEmissions, specifier: "%.2f") tons higher than the industry average.")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.bottom)
                        BenchmarkingChart(buildingEmissions: buildingEmissions, industryAverage: industryAverageEmissions)
                            .frame(height: 200)
                            .padding(.top)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .background(Color(hex: "#061b19").edgesIgnoringSafeArea(.all))
        .navigationTitle("Lighting Overuse")
        .navigationBarTitleDisplayMode(.inline)
    }
    // Helper function to create container views without titles
    func containerView(content: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(content)
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#396261"))
        .cornerRadius(10)
    }
    // Helper function to create chart container views without titles
    @ViewBuilder
    func chartContainerView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#396261"))
        .cornerRadius(10)
    }
    // Calculations and Helpers
    func calculateEmissionsOffset() -> Double {
        // Placeholder calculation for emissions offset
        return 5.0
    }
    func calculatePaybackPeriod() -> Double {
        let upgradeCost = 40000.0 // in dollars
        let annualSavings = 10000.0 // in dollars
        return upgradeCost / annualSavings
    }
    func simulateEmissionsIncrease() -> Double {
        // Simulate emissions increase based on selectedPeriod
        switch selectedPeriod {
        case "Last Year":
            return 15.0
        case "Last Month":
            return 4.0
        case "Yesterday":
            return 0.8
        default:
            return 0.0
        }
    }
}
// MARK: - WaterLeakDetailView
struct WaterLeakDetailView: View {
    init() {
        // Set navigation bar title color to white
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // Selected time period for water usage increase
    @State private var selectedPeriod = "Last Year"
    let timePeriods = ["Last Year", "Last Month", "Yesterday"]
    // Placeholder data for water usage breakdown
    let waterBreakdown = [
        EnergyConsumption(category: "Bathroom", percentage: 50),
        EnergyConsumption(category: "Kitchen", percentage: 20),
        EnergyConsumption(category: "Irrigation", percentage: 15),
        EnergyConsumption(category: "Other", percentage: 15)
    ]
    // Benchmarking data
    let industryAverageUsage = 5000.0 // Gallons per year
    let buildingUsage = 7000.0        // Gallons per year
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Problem Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Problem")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Water 💧")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("Bathroom leak leading to excessive water usage")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Solution Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Solution")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Repair 🔧")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("Fix the bathroom leak to prevent water wastage and reduce water bills.")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Estimated Water Savings
                VStack(alignment: .leading, spacing: 5) {
                    Text("Estimated Water Savings")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Savings 💧")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("\(String(format: "%.2f", calculateWaterSavings())) gallons per year")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Cost-Benefit Analysis Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Cost-Benefit Analysis")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Financial 💰")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text("Estimated Repair Cost: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("$2,000")
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Text("Estimated Annual Savings: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("$1,200")
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Text("Payback Period: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("\(String(format: "%.1f", calculatePaybackPeriod())) years")
                                    .foregroundColor(.white)
                            }
                        }
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
                // Water Usage Increase
                VStack(alignment: .leading, spacing: 5) {
                    Text("Water Usage Increase")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    chartContainerView {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 5) {
                                Text("Usage Graph💧")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.lightTurquoise)
                            }
                            .padding(.bottom, 5)
                            Picker("Select Time Period", selection: $selectedPeriod) {
                                ForEach(timePeriods, id: \.self) { period in
                                    Text(period)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.vertical)
                            Text("Since \(selectedPeriod): \(simulateWaterUsageIncrease(), specifier: "%.2f") gallons")
                                .font(.headline)
                                .foregroundColor(.white)
                            WaterUsageChart(selectedPeriod: $selectedPeriod)
                                .frame(height: 200)
                                .padding(.top)
                        }
                    }
                }
                // Water Consumption Breakdown
                VStack(alignment: .leading, spacing: 5) {
                    Text("Water Consumption Breakdown")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    chartContainerView {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 5) {
                                Text("Breakdown")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.lightTurquoise)
                            }
                            .padding(.bottom, 5)
                            EnergyBreakdownChart(energyData: waterBreakdown)
                                .frame(height: 200)
                                .padding(.top)
                        }
                    }
                }
                // Benchmarking Section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Benchmarking")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Text("Water Usage 💧")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.lightTurquoise)
                        }
                        .padding(.bottom, 5)
                        Text("Your building's water usage is \(buildingUsage, specifier: "%.2f") gallons per year, which is \(buildingUsage - industryAverageUsage, specifier: "%.2f") gallons higher than the industry average.")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.bottom)
                        BenchmarkingChart(buildingEmissions: buildingUsage, industryAverage: industryAverageUsage, unit: "Gallons")
                            .frame(height: 200)
                            .padding(.top)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "#396261"))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .background(Color(hex: "#061b19").edgesIgnoringSafeArea(.all))
        .navigationTitle("Bathroom Leak")
        .navigationBarTitleDisplayMode(.inline)
    }
    // Helper function to create container views without titles
    func containerView(content: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(content)
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#396261"))
        .cornerRadius(10)
    }
    // Helper function to create chart container views without titles
    @ViewBuilder
    func chartContainerView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#396261"))
        .cornerRadius(10)
    }
    // Calculations and Helpers
    func calculateWaterSavings() -> Double {
        // Placeholder calculation for water savings
        return 2000.0
    }
    func calculatePaybackPeriod() -> Double {
        let repairCost = 2000.0 // in dollars
        let annualSavings = 1200.0 // in dollars
        return repairCost / annualSavings
    }
    func simulateWaterUsageIncrease() -> Double {
        // Simulate water usage increase based on selectedPeriod
        switch selectedPeriod {
        case "Last Year":
            return 2000.0
        case "Last Month":
            return 500.0
        case "Yesterday":
            return 50.0
        default:
            return 0.0
        }
    }
}
// MARK: - HVACDataPoint Model
struct HVACDataPoint: Identifiable {
    let id = UUID()
    let hvacAge: Double
    let emissionsOffset: Double
}
// MARK: - DataLoader Class
class DataLoader {
    var dataPoints: [HVACDataPoint] = []
    init() {
        loadCSV()
    }
    func loadCSV() {
        guard let fileURL = Bundle.main.url(forResource: "emissions_data", withExtension: "csv") else {
            print("CSV file not found")
            return
        }
        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
            for line in lines.dropFirst() { // Skip the header
                let values = line.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                if values.count == 2,
                   let hvacAge = Double(values[0]),
                   let emissionsOffset = Double(values[1]) {
                    let dataPoint = HVACDataPoint(hvacAge: hvacAge, emissionsOffset: emissionsOffset)
                    dataPoints.append(dataPoint)
                }
            }
        } catch {
            print("Error reading CSV file: \(error)")
        }
    }
}
// MARK: - EmissionsChart View
struct EmissionsChart: View {
    @Binding var selectedPeriod: String
    // Simulated data points for the emissions chart
    var emissionsData: [EmissionsDataPoint] {
        switch selectedPeriod {
        case "Last Year":
            return (1...12).map { month in
                EmissionsDataPoint(timePeriod: "M\(month)", emissions: Double.random(in: 5.0...10.0))
            }
        case "Last Month":
            return (1...4).map { week in
                EmissionsDataPoint(timePeriod: "W\(week)", emissions: Double.random(in: 8.0...10.0))
            }
        case "Yesterday":
            return (0...23).map { hour in
                EmissionsDataPoint(timePeriod: "\(hour)", emissions: Double.random(in: 9.0...10.0))
            }
        default:
            return []
        }
    }
    var body: some View {
        VStack {
            Chart {
                ForEach(emissionsData) { dataPoint in
                    LineMark(
                        x: .value("Time", dataPoint.timePeriod),
                        y: .value("Emissions", dataPoint.emissions)
                    )
                    .foregroundStyle(Color(hex: "#9d54ff"))
                    .symbol(Circle())
                    .interpolationMethod(.catmullRom)
                }
            }
            .chartXAxisLabel("Time", alignment: .center)
            .chartYAxisLabel("Emissions (tons CO₂)", alignment: .center)
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisGridLine()
                        .foregroundStyle(Color.white)
                    AxisTick()
                        .foregroundStyle(Color.white)
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) {
                    AxisGridLine()
                        .foregroundStyle(Color.white)
                    AxisTick()
                        .foregroundStyle(Color.white)
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .padding()
        }
        .padding()
        .background(Color(hex: "#5ab8ad"))
        .cornerRadius(10)
    }
}
// MARK: - EmissionsDataPoint Model
struct EmissionsDataPoint: Identifiable {
    let id = UUID()
    let timePeriod: String
    let emissions: Double
}
// MARK: - WaterUsageChart View
struct WaterUsageChart: View {
    @Binding var selectedPeriod: String
    // Simulated data points for the water usage chart
    var waterUsageData: [WaterUsageDataPoint] {
        switch selectedPeriod {
        case "Last Year":
            return (1...12).map { month in
                WaterUsageDataPoint(timePeriod: "M\(month)", usage: Double.random(in: 300.0...700.0))
            }
        case "Last Month":
            return (1...4).map { week in
                WaterUsageDataPoint(timePeriod: "W\(week)", usage: Double.random(in: 600.0...700.0))
            }
        case "Yesterday":
            return (0...23).map { hour in
                WaterUsageDataPoint(timePeriod: "\(hour)", usage: Double.random(in: 20.0...30.0))
            }
        default:
            return []
        }
    }
    var body: some View {
        VStack {
            Chart {
                ForEach(waterUsageData) { dataPoint in
                    LineMark(
                        x: .value("Time", dataPoint.timePeriod),
                        y: .value("Usage", dataPoint.usage)
                    )
                    .foregroundStyle(Color(hex: "#9d54ff"))
                    .symbol(Circle())
                    .interpolationMethod(.catmullRom)
                }
            }
            .chartXAxisLabel("Time", alignment: .center)
            .chartYAxisLabel("Water Usage (gallons)", alignment: .center)
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisGridLine()
                        .foregroundStyle(Color.white)
                    AxisTick()
                        .foregroundStyle(Color.white)
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) {
                    AxisGridLine()
                        .foregroundStyle(Color.white)
                    AxisTick()
                        .foregroundStyle(Color.white)
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .padding()
        }
        .padding()
        .background(Color(hex: "#5ab8ad"))
        .cornerRadius(10)
    }
}
// MARK: - WaterUsageDataPoint Model
struct WaterUsageDataPoint: Identifiable {
    let id = UUID()
    let timePeriod: String
    let usage: Double
}
// MARK: - EnergyBreakdownChart View
struct EnergyBreakdownChart: View {
    let energyData: [EnergyConsumption]
    var body: some View {
        Chart {
            ForEach(energyData) { data in
                SectorMark(
                    angle: .value("Energy", data.percentage),
                    innerRadius: .ratio(0.5)
                )
                .foregroundStyle(by: .value("Category", data.category)) // Color depends on category
            }
        }
        .chartForegroundStyleScale([
            "HVAC": Color(hex: "#00ff7b"),       // Dark Green
            "Lighting": Color(hex: "#9d54ff"),  // Purple
            "Equipment": Color(hex: "#54dbff"), // Blue
            "Other": Color(hex: "#f0ff5e"),
            "Bathroom": Color(hex: "#386bff"),  // Custom Blue
            "Kitchen": Color(hex: "#ff17b2"),   // Custom Orange
            "Irrigation": Color(hex: "#ff9c38") // Custom Green
        ])
        .chartLegend(.visible)
        .padding()
        .background(Color(hex: "#5ab8ad"))
        .cornerRadius(10)
    }
}
// MARK: - EnergyConsumption Model
struct EnergyConsumption: Identifiable {
    let id = UUID()
    let category: String
    let percentage: Double
}
// MARK: - BenchmarkingChart View
struct BenchmarkingChart: View {
    let buildingEmissions: Double
    let industryAverage: Double
    var unit: String = "tons CO₂"
    var body: some View {
        VStack {
            Chart {
                BarMark(
                    x: .value("Category", "Your Building"),
                    y: .value("Emissions", buildingEmissions)
                )
                .foregroundStyle(Color(hex: "54dbff"))
                BarMark(
                    x: .value("Category", "Industry Average"),
                    y: .value("Emissions", industryAverage)
                )
                .foregroundStyle(Color(hex: "9d54ff"))
            }
            .chartXAxisLabel("Category", alignment: .center)
            .chartYAxisLabel("Value (\(unit))", alignment: .center)
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisGridLine()
                        .foregroundStyle(Color.white)
                    AxisTick()
                        .foregroundStyle(Color.white)
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) {
                    AxisGridLine()
                        .foregroundStyle(Color.white)
                    AxisTick()
                        .foregroundStyle(Color.white)
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .padding()
        }
        .padding()
        .background(Color(hex: "#5ab8ad"))
        .cornerRadius(10)
    }
}
