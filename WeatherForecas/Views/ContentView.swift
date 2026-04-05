//
//  ContentView.swift
//  WeatherForecas
//
//  Created by mierlin on 26/03/26.
//

import SwiftUI   //import SwiftUI → cuando la estructura es una vista

//Paso 1️⃣ crear la vista
struct ContentView: View {
    
    //Guardamos los dias en una Variable
    let days: [DayWeather] = [
        DayWeather(day: "Mon", isRainy: false, high: 70, low: 50),
        DayWeather(day: "Tue", isRainy: true,  high: 65, low: 48),
        DayWeather(day: "Wed", isRainy: false, high: 75, low: 55),
        DayWeather(day: "Thu", isRainy: true,  high: 60, low: 45),
        DayWeather(day: "Fri", isRainy: false, high: 80, low: 58),
        DayWeather(day: "Sat", isRainy: false, high: 85, low: 62),
        DayWeather(day: "Sun", isRainy: true,  high: 63, low: 47)
    ]
    
    
    var body: some View {
        
        VStack{
            
            //Resumen de la semana:
            WeekForecast(weekLabel: "Mar 31 - Apr 6", forecasts: days)
            
            //Cards individuales con Scroll - le dice a Swift que el scroll es hacia los lados ↔️
        ScrollView(.horizontal) {
            HStack {
                ForEach(days, id: \.day) {weather in
                    DayForecast(weather: weather)
                }
            }
            }
        }
    }
}




#Preview {
    ContentView()
}
