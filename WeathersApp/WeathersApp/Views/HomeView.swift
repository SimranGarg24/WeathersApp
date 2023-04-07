//
//  HomeView.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 04/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm = ContentViewModel()
    @State private var rootPresenting: Bool = false
    @State private var lat: String = "30.68"
    @State private var lon: String = "76.7221"
    
    
    var body: some View {
        NavigationView{

            ZStack{
                //MARK: Background Image
                if vm.currWeather.weather != nil{
                    if vm.currWeather.weather![0].icon.suffix(1) == "n"{
                        Image("Image 1")
                            .resizable()
                            .ignoresSafeArea()
                    }
                    else{
                        Image("Image")
                            .resizable()
                            .ignoresSafeArea()
                    }
                }
                
                VStack(alignment: .leading, spacing: 10){
                    
                    HStack{
                        Image("location")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .colorInvert()
                        //MARK: Location Name
                        if vm.currWeather.name != ""{
                            Text(vm.currWeather.name ?? "")
                                .foregroundColor(.white)
                                .font(.title2)
                        }else{
                            Text("Unnamed")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        //MARK: Plus Button
                        //Navigates to Selection View to enter new coordinates
                        NavigationLink(destination: SelectionView( rootPresenting: $rootPresenting, lat: $lat, lon: $lon), isActive: $rootPresenting){
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }
                    }
                    //MARK: Temperature
                    if vm.currWeather.main != nil{
                        Text("\(Int(vm.currWeather.main!.temp))º")
                            .font(.system(size: 120))
                            .foregroundStyle(.linearGradient(colors: [.white, .white.opacity(0.3)], startPoint: .top, endPoint: .bottom))
                    }
                    
                    if vm.currWeather.weather != nil{
                        HStack(alignment: .top){
                            
                            VStack(spacing:1){
                                //MARK: Weather Condition Icon
                                if vm.currWeather.weather![0].icon != "01d"{
                                    AsyncImage(url: URL(string:"https://openweathermap.org/img/wn/\(String(describing: vm.currWeather.weather![0].icon))@2x.png")){ phase in
                                        if let image = phase.image{
                                            // Icon from API
                                            image
                                                .resizable()
                                                .frame(width:60, height: 60)
                                            
                                        }else{
                                            //Activity Indicator Till the icon is loading show
                                            ProgressView()
                                                .frame(width:60, height: 60)
                                        }
                                    }
                                }
                                else{
                                    //Icon for Clear Sky
                                    Image(systemName: "sun.max.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                //MARK: Weather Description
                                Text(vm.currWeather.weather![0].description.capitalized)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
                VStack{
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("Weather Now")
                            .font(.title2)
                            .bold()
                        
                        HStack{
                            
                            if vm.currWeather.main != nil{
                                VStack(alignment: .leading){
                                    
                                    //MARK: Feel Like
                                    SheetView(imageName: "celsius" , title: "Feel Like", content: "\(Int(vm.currWeather.main!.feelsLike))º")
                                    
                                    //MARK: Humidity
                                    SheetView(imageName: "humidity" , title: "Humidity", content: "\(Int(vm.currWeather.main!.humidity))%")
                                    
                                    
                                }
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading){
                                if vm.currWeather.wind != nil{
                                    //MARK: Wind Speed
                                    SheetView(imageName: "wind", title: "Wind Speed", content: "\(Int(vm.currWeather.wind!.speed * (18/5))) km/h")
                                }
                                if vm.currWeather.visibility != nil{
                                    
                                    //MARK: Visibility
                                    SheetView(imageName:"visibility", title: "Visibility", content: "\(Int(vm.currWeather.visibility!/1000)) km")
                                    
                                }
                            }
                        }
                        .padding()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.white.opacity(0.98))
                }
                
            }
            .onAppear{
                //Setting latitude and longitude entered by the user
                    vm.lat = lat
                    vm.lon = lon
                    vm.fetchWeather()
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
