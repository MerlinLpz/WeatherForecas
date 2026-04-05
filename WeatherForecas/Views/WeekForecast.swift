//
//  WeekForecast.swift
//  WeatherForecas
//
//  Created by mierlin on 04/04/2026.
//

import  SwiftUI

//paso 1️⃣ el molde struct WeekForecast:
struct WeekForecast: View {
    let weekLabel: String
    let forecasts: [DayForecast]  // ← la lista de todos los días
    
    //PRIMERA Propieda Computada - Promedio de temperaturas altas
    var averageHigh: Int {
        let total = forecasts.reduce(0) { $0 + $1.high} //  Empieza en cero - Recorre toda la lista - Suma la propiedad que necesitas
        return total / forecasts.count                  //Divide entre cuántos hay
    }
    
    //SEGUNDA Propieda Computada - Promedio de temperaturas bajas
    var averageLow: Int {
        let total = forecasts.reduce(0) { $0 + $1.low} //.reduce → suma Es una función que recorre toda la lista y va sumando
        return total / forecasts.count
    }
    
    //TERCERA Propieda Computada - Dias de sol y lluvia
    var sunnyDays: Int {
        forecasts.filter { !$0.isRainy }.count//.filter - Recorre la lista y solo guarda los que cumplen la condición. En este caso los días soleados.
    }
    
    var rainyDays: Int {
        forecasts.filter { $0.isRainy }.count //{ $0.isRainy } = “solo quiero los días que están lloviendo”
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(weekLabel)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack {
                Label("\(sunnyDays) sunny", systemImage: "sun.max.fill")
                    .foregroundStyle(Color.yellow)
                Label("\(rainyDays) rainy", systemImage: "cloud.rain.fill")
                    .foregroundStyle(Color.black)
            }
            Text("AVG High: \(averageHigh)°")
                .fontWeight(.semibold)
            Text("Avg Low: \(averageLow)°")
                .foregroundStyle(Color.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: 0.1))
        .cornerRadius(12)
        .padding()
    }
}

