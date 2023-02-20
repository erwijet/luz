//
//  ContentView.swift
//  luz
//
//  Created by Tyler Holewinski on 2/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var lightsOn = true
    
    var body: some View {
        VStack {
            Text("Luz - Manage Lights")
            Toggle("Lights", isOn: $lightsOn)
                .toggleStyle(.switch)
                .onChange(of: lightsOn, perform: { value in
                    LuzServer.shared.turnLights(lightsOn ? .on : .off)
                })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
