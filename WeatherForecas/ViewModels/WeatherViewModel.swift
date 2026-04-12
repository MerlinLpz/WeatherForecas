//
//  WeatherViewModel.swift
//  WeatherForecas
//
//  Created by mierlin on 11/04/2026.
//

import SwiftUI
import Combine

//🟠 un struct se copia, una class se comparte.
//🟠 ObservableObject -> Es un protocolo que dice a swiftUI-> "Este objeto puede cambiar — esté atento" 👀
//🟠 @Published dice - cuando este valor cambie avisa a todas las vistas que me observan


class WeatherViewModel: ObservableObject {
    @Published var state: ViewState = .loading // Estas dos propiedades viven en contentView
    @Published var isCelsius: Bool = false
    @Published var days: [DayWeather] = []
    
    //creamos la primera funciones
    func loadWeather() {
        let service = WeatherService()
        do {
            let days = try service.fetchWeather(for: "Milano")
            self.days = days
            state = .success
            
        } catch let error as WeatherError {
            state = .error(error)
            
        } catch {
            state = .error(.unknown) //.unknown -> error desconocido
        }
    }
    
    //Creamos la segunda funcion
    func errorMessage(for error: WeatherError) -> String {
        switch error {
        case .noInternet:
            return "Sin conexión a internet 📡"
        case .invalidResponse:
            return "Respuesta inválida del servidor 🖥️"
        case .cityNotFound:
            return "Ciudad no encontrada 🗺️"
        case .unknown:
            return "Algo salió mal. Intenta de nuevo 🔄"
        }
    }
} // Hasta aqui - Conectamos el ViewModels a ConterntView
