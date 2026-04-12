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
    func fetchWeather(for city: String) async throws  -> [DayWeather] {
        
        //Construir la url
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(Secrets.apiKey)&units=metric&cnt=40"
        
        guard let url = URL(string: urlString) else {
            throw WeatherError.cityNotFound
        }
        
        print("URL construida: \(url)")
        
        // Segundo - Paso - Pedir los datos a internet - URLSession Es la herramienta de Swift para hacer peticiones a internet
        let (data, _) = try await URLSession.shared.data(from: url)
        
        print("Datos Recividos: \(data.count) bytes")
        
        // Paso 3.1 — decodificar el JSON
        let response = try JSONDecoder().decode(ForecastResponse.self, from: data)
        
       
        // Filtrar un resultado por día
        var seenDays: Set<String> = []
        let uniqueItems = response.list.filter { item in
            
            let day = dayName(from: item.dt_txt)
            if seenDays.contains(day) {
                return false
                
            }else {
                seenDays.insert(day)
                return true
            }
        }
        
        // Paso 4 — convertir ForecastItem en DayWeather
        let days = uniqueItems.map { item in
            
            DayWeather(
                day: dayName(from: item.dt_txt),
                isRainy: item.weather.first?.main == "Rain",
                high: Int(item.main.temp_max),
                low: Int(item.main.temp_min)
            )
            
        }
        
        return days
    }
    
    //formato fecha - Ahora mismo  - "2026-04-12 12:00:00"
    //Nosotros queremos mostrar asi - "Sun"  // el día de la semana abreviado
    private func dayName(from dateString: String) -> String {
        let inputFormatter = DateFormatter()                   // inputFormatter - formato de entrada
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let outputFormatters = DateFormatter()
        outputFormatters.dateFormat = "EEE"     // "EEE" = Mon, Tue, Wed...
        
        guard let date = inputFormatter.date(from: dateString) else {
            return dateString   // si falla devuelve el string original
        }
        
        return outputFormatters.string(from: date)
    }
}
