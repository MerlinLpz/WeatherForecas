//
//  ContentView.swift
//  WeatherForecas
//
//  Created by mierlin on 26/03/26.
//

import SwiftUI   //import SwiftUI → cuando la estructura es una vista

//Paso 1️⃣ crear la vista
struct ContentView: View {
    
    //Guardamos los dias en una Variable
    let days: [DayWeather] = [
        DayWeather(day: "Mon", isRainy: false, high: 70, low: 50),
        DayWeather(day: "Tue", isRainy: true,  high: 65, low: 48),
        DayWeather(day: "Wed", isRainy: false, high: 75, low: 55),
        DayWeather(day: "Thu", isRainy: true,  high: 60, low: 45),
        DayWeather(day: "Fri", isRainy: false, high: 80, low: 58),
        DayWeather(day: "Sat", isRainy: false, high: 85, low: 62),
        DayWeather(day: "Sun", isRainy: true,  high: 63, low: 47)
    ]
    
    //🔄 Estado — false = Fahrenheit, true = Celsius
    @State var isCelsius: Bool = false //  @State - Es clave para que la interfaz sea reactiva
    @State var state: ViewState = .loading //@State que guarda el estado actual
    
    var body: some View {
        
        switch state {
            
            //⏳ CArgando
        case .loading:
            VStack {
                ProgressView()  // ← spinner girando
                Text("Cargando clima...")
                    .foregroundStyle(.secondary)
            }
            .onAppear {
                loadWeather()
            }
            
            //✅ Datos listos
        case .success:
            VStack{
                
                //🔄 Botón para cambiar entre °F y °C
                Button {
                    isCelsius.toggle()
                } label: {
                    Text(isCelsius ? "Switch to °F" : "Switch to °C")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                        .cornerRadius(20)
                }
                //Resumen de la semana:
                WeekForecast(weekLabel: "Mar 31 - Apr 6", forecasts: days, isCelsius: isCelsius)
                
                //Cards individuales con Scroll - le dice a Swift que el scroll es hacia los lados ↔️
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(days, id: \.day) {weather in
                            DayForecast(weather: weather, isCelcius: isCelsius)
                        }
                    }
                    .padding(.leading)
                }
                Spacer() //Empuja todo hacia arriba
            }
            .padding(.top)
            
        case .error(let error):
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(Color.orange)
                Text(errorMessage(for: error))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.secondary)
                Button("Reintar") {
                    state = .loading
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundStyle(Color.white)
                .cornerRadius(20)
            }
            .padding()
            
            
        }
    }
    // ⏳ Simula la carga del clima
    func loadWeather() {
        let service = WeatherService()
        
        do {
            try service.fetchWeather(for: "Milano")
            state = .success
        }catch let error as WeatherError {
            state = .error(error)
        }catch {
            state = .error(.unknown)
        }
    }
    
    func errorMessage(for error: WeatherError) -> String {
        switch error {
        case .noInternet:
             "Sin conexión a internet 📡"  // Sin return — implicit return
        case .invalidResponse:
            "Respuesta incorrecta del servidor 🔧"
        case .cityNotFound:
           "Ciudad no encontrada 🗺️"      // Sin return — implicit return
        case .unknown:
          "Algo salió mal. Intenta de nuevo 🔄"
        }
    }
}



#Preview {
    ContentView()
}

