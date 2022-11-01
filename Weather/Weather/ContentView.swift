import SwiftUI

struct ContentView: View {
    let cityName: String
    
    @State private var isNight = false
    var body: some View {
        ZStack {
            background
            content
        }
    }
    
    var background: some View {
        BackgroundView(isNight: isNight)
    }
    
    var content: some View {
        VStack {
            city
            weather
                .padding(.bottom, 40)
            days
            button
        }
    }
    
    var city: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
    
    var weather: some View {
        VStack(spacing: 8.0) {
            WeatherSymbol(title: isNight ? "moon.stars.fill" : "cloud.sun.fill", size: 180)
            Text("76°") // Option + Shift + 8
                .font(.system(size: 70))
                .foregroundColor(.white)
        }
    }
    
    let week = ["TUE", "WED", "THU", "FRI", "SAT"]
    let images = ["cloud.sun.fill", "sun.max.fill", "wind.snow", "cloud.sun.rain.fill", "snow"]
    var days: some View {
        HStack {
            ForEach(0 ..< 5) { index in
                WeatherDayVeiw(day: week[index],
                               value: Int.random(in: 30...80),
                               symbol: images[index])
            }
        }
    }
    
    var button: some View {
        Button {
            isNight.toggle()
        } label: {
            WeatherButton(title: "Change Day Time",
                          backgroundColor: .white,
                          foregroundColor: .blue)
        }
        .frame(maxHeight: .infinity)
    }
}

struct WeatherDayVeiw: View {
    var day: String
    var value: Int
    var symbol: String
    var body: some View {
        VStack {
            Text(day)
                .font(.system(size: 16, weight: .medium))
            WeatherSymbol(title: symbol, size: 40)
            Text("\(value)°")
                .font(.system(size: 30))
        }
        .foregroundColor(.white)
    }
}

struct WeatherSymbol: View {
    let title: String
    let size: CGFloat
    var body: some View {
        Image(systemName: title)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cityName: "Alma-Ata, KZ")
    }
}

struct BackgroundView: View {
    var isNight: Bool
    
    var body: some View {
        LinearGradient(colors: [isNight ? .black : .blue,
                                isNight ? .gray : Color("ice")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct WeatherButton: View {
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .font(.system(size: 20, weight: .bold))
            .cornerRadius(10)
    }
}
