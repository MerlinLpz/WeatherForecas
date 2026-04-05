//
//  ContentView.swift
//  WeatherForecas
//
//  Created by mierlin on 26/03/26.
//

import SwiftUI

//Paso 1️⃣ crear la vista
struct ContentView: View {
    
    //Guardamos los dias en una Variable
    let day: [DayForecast] = [
        DayForecast(day: "Mon", isRainy: false, high: 70, low: 50),
        DayForecast(day: "Tue", isRainy: true,  high: 65, low: 48),
        DayForecast(day: "Wed", isRainy: false, high: 75, low: 55),
        DayForecast(day: "Thu", isRainy: true,  high: 60, low: 45),
        DayForecast(day: "Fri", isRainy: false, high: 80, low: 58),
        DayForecast(day: "Sat", isRainy: false, high: 85, low: 62),
        DayForecast(day: "Sun", isRainy: true,  high: 63, low: 47)
    ]
    
    
    var body: some View {
        
        VStack{
            
            //Resumen de la semana:
            WeekForecast(weekLabel: "Mar 31 - Apr 6", forecasts: day)
            
            //Cards individuales con Scroll - le dice a Swift que el scroll es hacia los lados ↔️
        ScrollView(.horizontal) {
            HStack {
                ForEach(day, id: \.day) { day in
                    day
                }
            }
            }
        }
    }
}




#Preview {
    ContentView()
}
