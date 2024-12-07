//
//  ContentView.swift
//  Where-TO-eat
//
//  Created by Nihaar Eppe on 4/23/24.
//

//
//  ContentView.swift
//  Where-TO-eat
//
//  Created by Nihaar Eppe on 4/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Where-TO-eat")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                VStack(spacing: 20) {
                    NavigationLink(destination: InputRestaurantsView()) {
                        Text("Input Restaurants")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SelectRandomRestaurantView()) {
                        Text("Select Random Nearby Restaurant")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}




#Preview {
    ContentView()
}
