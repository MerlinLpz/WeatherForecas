//
//  ContentView.swift
//  WeatherForecas
//
//  Created by mierlin on 26/03/26.
//

import SwiftUI   //import SwiftUI → cuando la estructura es una vista

//Paso 1️⃣ crear la vista - el Almacen - viewModel
struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
   
    
    var body: some View {
        
        switch viewModel.state {
            
            //⏳ CArgando
        case .loading:
            VStack {
                ProgressView()  // ← spinner girando
                Text("Cargando clima...")
                    .foregroundStyle(.secondary)
            }
            .onAppear {
                viewModel.loadWeather()
            }
            
            //✅ Datos listos
        case .success:
            VStack{
                
                //🔄 Botón para cambiar entre °F y °C
                Button {
                    viewModel.isCelsius.toggle()
                } label: {
                    Text(viewModel.isCelsius ? "Switch to °F" : "Switch to °C")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                        .cornerRadius(20)
                }
                //Resumen de la semana:
                WeekForecast(weekLabel: "Mar 31 - Apr 6", forecasts: viewModel.days, isCelsius: viewModel.isCelsius)
                
                //Cards individuales con Scroll - le dice a Swift que el scroll es hacia los lados ↔️
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.days, id: \.day) {weather in
                            DayForecast(weather: weather, isCelcius: viewModel.isCelsius)
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
                Text(viewModel.errorMessage(for: error))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.secondary)
                Button("Reintar") {
                    viewModel.state = .loading
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
   
}



#Preview {
    ContentView()
}

