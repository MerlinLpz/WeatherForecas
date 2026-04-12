//
//  WeatherService.swift
//  WeatherForecas
//
//  Created by mierlin on 06/04/2026.
//

import Foundation

//🟠 Este archivo es el servicio de tu app — su único trabajo es buscar y entregar datos del clima.
//🟠Para llamar una api real - aqui van los cambios
//🟠 se necesitan hacer 3 Pasos -


//Struct de soporte
// Codable OpenWeather responde con JSON
//Tercer - paso - Codable structs para decodificar el JSON de OpenWeather
struct ForecastResponse: Codable {
    let list: [ForecastItem]
}

struct ForecastItem: Codable {
    let dt_txt: String
    let main: MainInfo
    let weather: [WeatherInfo]
}

struct MainInfo: Codable {
    let temp_max: Double
    let temp_min: Double
}

struct WeatherInfo: Codable {
    let main: String
}


//struct principal
struct WeatherService {
    
    //Primer - Paso - async throws La función ahora tarda tiempo, entonces necesita async:
    private let apiKey = "8f1d6348ee08e51ef00a12f85d485b45"
    
    func fetchWeather(for city: String) async throws  -> [DayWeather] {
        
        //Construir la url
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric&cnt=7"
        
        guard let url = URL(string: urlString) else {
            throw WeatherError.cityNotFound
        }
        
        print("URL construida: \(url)")
        
        // Segundo - Paso - Pedir los datos a internet - URLSession Es la herramienta de Swift para hacer peticiones a internet
        let (data, _) = try await URLSession.shared.data(from: url)
        
        print("Datos Recividos: \(data.count) bytes")
        
        // Paso 3.1 — decodificar el JSON
        let response = try JSONDecoder().decode(ForecastResponse.self, from: data)
        
        // Paso 4 — convertir ForecastItem en DayWeather
        let days = response.list.map { item in
            DayWeather(day: item.dt_txt, isRainy: item.weather.first?.main == "Rain", high: Int(item.main.temp_max), low: Int(item.main.temp_min))
            
        }
        
        return days
    }
}
