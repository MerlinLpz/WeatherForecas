//
//  DayForecast.swift
//  WeatherForecas
//
//  Created by mierlin on 04/04/2026.
//

import SwiftUI

//Paso 2️⃣ - Encapsular Pronostico - vista mas dimamico con propiedade let day..
struct DayForecast: View {
    let day: String
    let isRainy: Bool  //necesita una propiedad calculada
    let high: Int
    let low: Int
    
    //3️⃣Creamos una propiedad calculada - para - let isRainy: Bool (lluvioso o soleado)
    var iconName: String {// no guarda nada usa el valor si dependiendo el caso si esta lloviendo o soleado
        if isRainy {
            return "cloud.rain.fill"
            
        }else {
            return "sun.max.fill"
        }
    }
    
    //4️⃣ Creamos la propiedad Calculada para -  let isRainy: Bool (color)
    var iconColor: Color {
        if isRainy {
            return Color.black
        }else {
            return Color.yellow
        }
    }
    
    //5️⃣ Propiedad calculada - color de temperatura alta:
    var highTempColor: Color {
        if high > 70 {
            return Color.orange
        }else {
            return Color.primary
        }
    }
    
    var body: some View {
        VStack {
            Text(day)
                .font(Font.headline)
            Image(systemName: iconName)
                .font(Font.largeTitle)
                .foregroundStyle(iconColor)
                .padding(5)
            Text("High: \(high)°")
                .fontWeight(Font.Weight.semibold)
                .foregroundStyle(highTempColor)
            Text("Low: \(low)°")//Lo que está dentro de \() Swift lo convierte automáticamente a texto.
                .fontWeight(Font.Weight.medium)
                .foregroundStyle(Color.secondary)
        }
        .padding()
        
    }
}



