//
//  IOS18Slider.swift
//  IOS18VerticalSlider
//
//  Created by Vishnu on 2025-03-25.
//

import SwiftUI

struct IOS18Slider: View
{
    @Binding var slider: Slider
    let fill: Color
    let accessibilityImage: String
    
    var body: some View
    {
        VStack
        {
            Rectangle()
                .fill(fill)
                .adjustVolumeBar(slider: $slider)
                .frame(width: 60)
            
            Image(systemName: accessibilityImage)
                .resizable()
                .frame(width: 26, height: 26)
                .padding()
        }
        .padding()
    }
}

@propertyWrapper
struct Slider
{
    private var value: CGFloat
    let maxValue: CGFloat
    
    var wrappedValue: CGFloat
    {
        get { return value }
        set { value = max(6, min(maxValue, newValue) ) }
    }
    
    init(wrappedValue: CGFloat, maxValue: CGFloat)
    {
        self.maxValue = maxValue
        value = max(6, min(maxValue, wrappedValue))
    }
}

func GlossyBar(width: CGFloat) -> some View
{
    return RoundedRectangle(cornerRadius: width / 36)
        .fill(Color(.glossyBackground))
        .stroke(LinearGradient(gradient:
        Gradient(colors: [Color(.glossy), Color(.white), Color(.white), Color(.glossy2)]),
            startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing))
        .blendMode(.luminosity)
        .opacity(0.3)
}
