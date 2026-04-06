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
    let isCelcius: Bool // ← nueva propiedad
    
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
    
    //6️⃣ Computed Property gradiente de fondo
    var backgroundGradient: LinearGradient { //🟠 forma corta de => if{} else{}
        weather.isRainy ?
        LinearGradient(colors: [Color.gray, Color.white], startPoint: .top, endPoint: .bottom) :
        LinearGradient(colors: [Color.blue, Color.cyan], startPoint: .top, endPoint: .bottom)
    }
    
    //7️⃣ Computed Property - Convierte temperatura según el estado
    var displayHigh: Int {
        isCelcius ? Int((Double(weather.high) - 32) * 5/9) : weather.high
    }
    
    var displayLow: Int {
        isCelcius ? Int((Double(weather.low) - 32) * 5/9) : weather.low
    }
    
    var body: some View {
        ZStack {
            //Capa 1 - foondo Gradiente (abajo)
            backgroundGradient
                .cornerRadius(20)
        
            //Capa 2 - contenido de la card (arriba)
        VStack {
            Text(weather.day)
                .font(Font.headline)
                .foregroundStyle(Color.white)
                .padding(.top, 10)
            
            // Badge aquí — antes del icono
               Text(weather.isRainy ? "Rain" : weather.high > 75 ? "Hot" : "Sunny")
                   .font(.caption2)
                   .fontWeight(.semibold)
                   .foregroundStyle(.white)
                   .padding(.horizontal, 6)
                   .padding(.vertical, 3)
                   .background(.white.opacity(0.3))
                   .clipShape(Capsule())
            Image(systemName: iconName)
                .font(Font.largeTitle)
                .foregroundStyle(iconColor)
                .padding(5)
                
            Text("High: \(displayHigh)°")
                .fontWeight(Font.Weight.semibold)
                .foregroundStyle(highTempColor)
            Text("Low: \(displayLow)°")
                .fontWeight(Font.Weight.medium)
                .foregroundStyle(Color.white)
                
        }
        .padding()
        }
        .frame(width: 120, height: 170)
        .cornerRadius(7) // antes era 12
        .padding(5)
    }
}



