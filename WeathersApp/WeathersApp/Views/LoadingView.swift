//
//  LoadingView.swift
//  WeathersApp
//
//  Created by Saheem Hussain on 04/04/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack{
            
            Spacer()
            
            //MARK: Weather App
            VStack{
                Text("Weather")
                Text("App")
            }
            .font(.system(size: 60))
            .fontWeight(.bold)
            .foregroundStyle(.linearGradient(colors: [.white, .white.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                
            Spacer()
            
            //MARK: Launching
            Text("Launching")
                .font(.subheadline)
            //MARK: Activity Indicator
            ProgressView()
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.linearGradient(colors: [Color("Color"), Color("Color 1")], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
