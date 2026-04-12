//
//  WeatherService.swift
//  WeatherForecas
//
//  Created by mierlin on 06/04/2026.
//

import Foundation

//🟠 Este archivo es el servicio de tu app — su único trabajo es buscar y entregar datos del clima.

//PASO 2️⃣ y 3️⃣ - Servicio que busca el clima
struct WeatherService {
    
    //Ahora devuelve Result en lugar de throws
    func fetchWeather(for city: String) throws  -> [DayWeather] {
        
        guard !city.isEmpty else { throw WeatherError.cityNotFound } //"Asegúrate que city NO esté vacío — si no, lanza error"
        
        guard city != "error" else { throw WeatherError.noInternet} // "Asegúrate que city NO sea 'error' — si no, lanza error"
        
        // si llegamos aquí → todo está bien ✅ - Datos de Prueva por Ahora
        return [
            DayWeather(day: "Mon", isRainy: false, high: 70, low: 50),
            DayWeather(day: "Tue", isRainy: true,  high: 65, low: 48),
            DayWeather(day: "Wed", isRainy: false, high: 75, low: 55),
            DayWeather(day: "Thu", isRainy: true,  high: 60, low: 45),
            DayWeather(day: "Fri", isRainy: false, high: 80, low: 58),
            DayWeather(day: "Sat", isRainy: false, high: 85, low: 62),
            DayWeather(day: "Sun", isRainy: true,  high: 63, low: 47)
        ]
        
    }
}
