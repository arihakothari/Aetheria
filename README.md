# Aetheria - Revolutionizing Building Sustainability Management  

<p align="center">
  <img src="https://i.imgur.com/zSE31mi.png" alt="Homepage" width="25%" />
</p>

## Inspiration  
With sustainability at the forefront of global concerns, we recognized that buildings significantly contribute to resource consumption and waste generation. Yet, many facilities lack the granular data needed to make impactful changes. Inspired by the potential of IoT and machine learning to drive environmental efficiency, our team of four created a solution that empowers building managers to make data-driven decisions, reduce waste, and optimize resource usage. By harnessing technology, we believe we can transform buildings into sustainability models.  

## What It Does  
Aetheria is a Swift-based mobile application designed to revolutionize building sustainability management. While we plan to collect real-time data from strategically placed sensors throughout a building—including trash cans, rooms, electrical panels, water outlets, and HVAC systems—our current prototype simulates this data to provide a comprehensive overview of the building's environmental footprint. Key features include:  

- **Sustainability Dial**: Utilizes machine learning linear regression to compute an overall sustainability score, categorizing it as high, medium, or low based on historical and current data trends.  
- **Priority Ranking**: This section lists building sections from worst to best in terms of sustainability issues. Users can delve into each section to view detailed problems, AI-powered solutions, estimated offsets, and cost-benefit analyses.  
- **Interactive Map**: This section displays precise locations of identified issues within the building, enabling quick action and resource allocation.  
- **Trend Analysis**: Leverages historical data to perform comparative analyses, highlighting improvements or regressions in sustainability metrics over time.  

## How We Built It  
We developed Aetheria using Swift for a robust and intuitive iOS experience. Since we haven't implemented the physical sensors yet, we used a mock dataset to simulate sensor readings. Key technologies and methods used include:  

- **Data Processing**: All data processing and storage are handled locally within the app.  
- **Machine Learning**: Linear regression models were implemented directly in Swift using Apple's Core ML framework. AI-powered suggestions are generated using decision-tree algorithms and predefined rules within the app.  
- **Mapping**: MapKit was integrated for an interactive mapping feature to display the locations of identified issues.  

This approach allowed us to focus on developing a seamless user experience while ensuring the app is ready for future integration with real sensors.  

## Challenges We Ran Into  
- **Simulated Data**: Creating realistic sensor data streams to test functionalities effectively required understanding expected sensor outputs and interactions over time.  
- **Machine Learning Without Real Data**: Implementing robust models without access to real-world data was a challenge that required meticulous validation and testing.  
- **Component Integration**: Combining machine learning models, mock backend services, and a user-friendly interface required extensive debugging and planning.  
- **User Interface Design**: Designing an intuitive interface that presents complex sustainability data accessibly requires several iterations.  

## Accomplishments That We're Proud Of  
- Developing a fully functional software prototype within the hackathon timeframe.  
- Successfully implementing machine learning models to provide actionable sustainability insights.  
- Creating an intuitive user interface to make complex data accessible.  
- Building a strong foundation for future sensor integration and real-world application.  

## What We Learned  
- **Mobile Development**: Improved our skills in Swift and creating seamless iOS applications.  
- **Simulated Data**: Learned techniques to generate and work with mock datasets effectively.  
- **Machine Learning**: Gained insights into implementing models directly within a mobile app using Core ML.  
- **User Experience Design**: Enhanced our ability to present complex data in a user-friendly manner.  
- **Collaboration**: Learned the importance of adaptability and communication in overcoming challenges.  

## What's Next for Aetheria  
1. **IoT Sensor Development**: Build and deploy IoT sensors in real buildings to monitor energy consumption, temperature, air quality, and more.  
2. **Real-World Testing**: Test the system's functionality and refine data collection methods with live data.  
3. **Model Enhancement**: Improve machine learning models with real-world data to provide more accurate insights.  
4. **Scalability**: Expand the platform to support multiple buildings, contributing to broader sustainability efforts.  

## Built With  
- **Python**  
- **Swift**  
- **Team Collaboration**  

---
