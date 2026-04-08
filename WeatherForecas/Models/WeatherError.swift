//
//  WeatherError.swift
//  WeatherForecas
//
//  Created by mierlin on 06/04/2026.
//

import Foundation

//PASO 1️⃣ - Manejo de Errores - errores que puede tener nuestra app
enum WeatherError: Error {
    case noInternet           // ← sin conexión
    case invalidResponse     // ← respuesta incorrecta
    case cityNotFound        // ← ciudad no encontrada
    case unknown             // ← error desconocido
}


