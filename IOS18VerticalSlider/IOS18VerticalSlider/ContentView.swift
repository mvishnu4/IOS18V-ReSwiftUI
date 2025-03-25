//
//  ContentView.swift
//  IOS18VerticalSlider
//
//  Created by Vishnu on 2025-03-25.
//

import SwiftUI

struct ContentView: View
{
    @State var slider1: Slider = Slider(wrappedValue: 26, maxValue: 200)
    @State var slider2: Slider = Slider(wrappedValue: 46, maxValue: 200)
    @State var slider3: Slider = Slider(wrappedValue: 66, maxValue: 200)
    
    var body: some View
    {
        HStack
        {
            IOS18Slider(slider: $slider1, fill: .white, accessibilityImage: "sun.min")
            IOS18Slider(slider: $slider2, fill: .blue, accessibilityImage: "speaker.wave.2")
            IOS18Slider(slider: $slider3, fill: .green, accessibilityImage: "airpods.chargingcase.fill")
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
