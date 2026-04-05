//
//  DayForecast.swift
//  WeatherForecas
//
//  Created by mierlin on 04/04/2026.
//

import SwiftUI

//Paso 2️⃣ - Encapsular Pronostico 
struct DayForecast: View { //necesita datos → recibe DayWeather
    let weather: DayWeather
    
    //3️⃣Creamos una propiedad calculada - para - let isRainy: Bool (lluvioso o soleado)
    var iconName: String {
        weather.isRainy ? "cloud.rain.fill" : "sun.max.fill" //🟠 forma corta de => if{} else{}
    //  ¿está lloviendo?  → sí → "nube"    → no → "sol"
    }
    
    //4️⃣ Creamos la propiedad Calculada para -  let isRainy: Bool (color)
    var iconColor: Color {
        weather.isRainy ? Color.blue : Color.yellow
    }
    
    //5️⃣ Propiedad calculada - color de temperatura alta:
    var highTempColor: Color {
        weather.high > 70 ? Color.orange : Color.primary
//¿weather.high es mayor que 70?  →  sí → orange  →  no → primary
    }
    
    var body: some View {
        VStack {
            Text(weather.day)
                .font(Font.headline)
            Image(systemName: iconName)
                .font(Font.largeTitle)
                .foregroundStyle(iconColor)
                .padding(5)
            Text("High: \(weather.high)°")
                .fontWeight(Font.Weight.semibold)
                .foregroundStyle(highTempColor)
            Text("Low: \(weather.low)°")//Lo que está dentro de \() Swift lo convierte automáticamente a texto.
                .fontWeight(Font.Weight.medium)
                .foregroundStyle(Color.secondary)
        }
        .padding()
        
    }
}



