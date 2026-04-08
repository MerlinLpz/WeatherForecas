//
//  ViewState.swift
//  WeatherForecas
//
//  Created by mierlin on 07/04/2026.
//

import Foundation

//PASO 4️⃣ - Estados posibles de la vista
enum ViewState {
    case loading      // ⏳ cargando datos
    case success        // ✅ datos listos
    case error(WeatherError)   // ❌ algo falló — guarda el error específico
}
