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
    func fetchWeather(for city: String) throws {
        
        guard !city.isEmpty else { throw WeatherError.cityNotFound } //"Asegúrate que city NO esté vacío — si no, lanza error"
        
        guard city != "Error" else { throw WeatherError.noInternet} // "Asegúrate que city NO sea 'error' — si no, lanza error"
        
        // si llegamos aquí → todo está bien ✅
        print("Clima encontrado para \(city)")
    }
}
